import React, { useEffect, useRef } from 'react';
import useSVGCanvas from './useSVGCanvas.js';
import * as d3 from 'd3';

export default function GunDeathsChart(props) {
    //this is a generic component for plotting a d3 plot
    const d3Container = useRef(null);
    //this automatically constructs an svg canvas the size of the parent container (height and width)
    //tTip automatically attaches a div of the class 'tooltip' if it doesn't already exist
    //this will automatically resize when the window changes so passing svg to a useeffect will re-trigger
    const [svg, height, width, tTip] = useSVGCanvas(d3Container);

    const margin = 40;

    //TODO: modify or replace the code below to draw a more truthful or insightful representation of the dataset. This other representation could be a histogram, a stacked bar chart, etc.
    //this loop updates when the props.data changes or the window resizes
    //we can edit it to also use props.brushedState if you want to use linking
    useEffect(()=>{
        //wait until the data loads
        if(svg === undefined | props.data === undefined){ return }

        //aggregate gun deaths by state
        const data = props.data.states;

        //get data for each state
        const plotData = [];
        for(let state of data){
            let entry = {
                'count': state.count,
                'name': state.state,
                'abbreviation': state.abreviation,
                'male_count': state.male_count,
                'female_count': state.count - state.male_count,
                'genderRatio': state.male_count/state.count,
                'DeathRatio': state.male_count/(state.count - state.male_count),
                'population': parseInt(state.population)
            }
            plotData.push(entry)
        }

//        let yScale = d3.scaleLinear()
//            .domain(d3.extent(plotData,d=>((d.population)/500000)))
//            .range([height-margin-radius,margin+radius]);
//        let xScale = d3.scaleLinear()
//            .domain(d3.extent(plotData,d=>d.count))
//            .range([margin+radius,width-margin-radius]);
        //draw a line showing the mean values across the curve
        //this probably isn't actually regression
//        const regressionLine = [];
//        for(let i = 0; i <= 10; i+= 1){
//            let pvals = plotData.filter(d => Math.abs((d.population)/500000) <= .5);
//            let meanY = 0;
//            if(pvals.length > 0){
//                for(let entry of pvals){
//                    meanY += entry.count/pvals.length
//                }
//            }
//            let point = [xScale(i),yScale(meanY)]
//            regressionLine.push(point)
//        }

        //scale color by gender ratio for no reason
//        let colorScale = d3.scaleDiverging()
//            .domain([0,.5,1])
//            .range(['magenta','white','navy']);

        //draw the circles for each state
//        svg.selectAll('.dot').remove();
//        svg.selectAll('.dot').data(plotData)
//            .enter().append('circle')
//            .attr('cx',d=> xScale(d.count))
//            .attr('cy',d=> yScale((d.population)/500000))
//            .attr('fill',d=> colorScale(d.genderRatio))
//            .attr('r',10)
//            .on('mouseover',(e,d)=>{
//                let string = d.name + '</br>'
//                    + 'Male Deaths: ' + d.male_count + '</br>'
//                    + 'Female Deaths: ' + d.female_count + '</br>'
//                    + 'Ratio of M/F deaths: ' + d.DeathRatio.toFixed(2);
//                props.ToolTip.moveTTipEvent(tTip,e)
//                tTip.html(string)
//            }).on('mousemove',(e)=>{
//                props.ToolTip.moveTTipEvent(tTip,e);
//            }).on('mouseout',(e,d)=>{
//                props.ToolTip.hideTTip(tTip);
//            });

        //Define xScale
        const xScale = d3.scaleBand()
            .domain(plotData.map((d) => d.abbreviation))
            .range([margin, (width - 10)])
            .padding(0.05);

        //Define yScale
        const yScale = d3.scaleLinear()
            .domain([d3.min(plotData, (d) => d.count), d3.max(plotData, (d) => d.count)])
            .range([height - margin, margin]);

        //Create the male bars in the graph
        svg.selectAll('.male_bar')
            .data(plotData)
            .enter()
            .append('rect')
            .attr('class', 'male_bar')
            .attr('x', d => xScale(d.abbreviation))
            .attr('y', d => yScale(d.male_count))
            .attr('width', xScale.bandwidth()/2)
            .attr('height', d => height - margin - yScale(d.male_count))
            .attr('fill', 'steelblue')
            .on('mouseover', (e, d) => {
                const tooltipText = d.name + '</br>'
                    + 'Male Gun Deaths: ' + d.male_count + '<br>'
                    + 'Percentage of M deaths from total: ' + (((d.male_count/d.count) * 100).toFixed(2)) + '%';
                props.ToolTip.moveTTipEvent(tTip, e);
                tTip.html(tooltipText);
            })
            .on('mousemove', (e) => {
                props.ToolTip.moveTTipEvent(tTip, e);
            })
            .on('mouseout', () => {
                props.ToolTip.hideTTip(tTip);
            });

        //Create the female bars in the chart
        svg.selectAll('.female_bar')
            .data(plotData)
            .enter()
            .append('rect')
            .attr('class', 'female_bar')
            .attr('x', (d) => xScale(d.abbreviation) + xScale.bandwidth()/2)
            .attr('y', (d) => yScale(d.female_count))
            .attr('width', xScale.bandwidth()/2) // Half of the bandwidth
            .attr('height', (d) => height - margin - yScale(d.female_count))
            .attr('fill', 'lightgreen')
            .on('mouseover', (e, d) => {
                const tooltipText = d.name + '</br>'
                    + 'Female Gun Deaths: ' + d.female_count + '<br>'
                    + 'Percentage of F deaths from total: ' + (((d.female_count/d.count) * 100).toFixed(2)) + '%';
                props.ToolTip.moveTTipEvent(tTip, e);
                tTip.html(tooltipText);
            })
            .on('mousemove', (e) => {
                props.ToolTip.moveTTipEvent(tTip, e);
            })
            .on('mouseout', () => {
                props.ToolTip.hideTTip(tTip);
            });

        //Create the x axis
        svg.append('g')
            .attr('class', 'x-axis')
            .attr('transform', `translate(0,${height - margin})`)
            .call(d3.axisBottom(xScale))
            .selectAll('text')
            .style('text-anchor', 'middle');

        //Create y axis
        svg.append('g')
            .attr('class', 'y-axis')
            .attr('transform', `translate(${margin},0)`)
            .call(d3.axisLeft(yScale));

        //Label for graph
        svg.append('text')
            .attr('x', width/1.75)
            .attr('y', margin/2)
            .attr('text-anchor', 'middle')
            .attr('font-size', 20)
            .attr('font-weight', 'bold')
            .text('Total deaths by guns across states');

        //Label for X axis
        svg.append('text')
            .attr('x', width / 2)
            .attr('y', height - 10)
            .attr('font-size', 15)
            .attr('text-anchor', 'middle')
            .text('Abbreviations');

        //Label for Y axis
        svg.append('text')
            .attr('transform', 'rotate(-90)')
            .attr('x', -height / 2)
            .attr('y', margin/2 - 10)
            .attr('font-size', 10)
            .attr('text-anchor', 'middle')
            .text('Total Deaths');

    }, [props.data,svg]);

    return (
        <div
            className={"d3-component"}
            style={{'height':'99%','width':'99%'}}
            ref={d3Container}
        ></div>
    );
}
