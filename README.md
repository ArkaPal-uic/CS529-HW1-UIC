# CS529-HW1-UIC

1. Blue colour: using d3.interpolateBlues
2. To coordinate colour with probability: utilised variable “stateCountsDeaths” and mapped the interpolation with it.
3. To keep scale consistent with map: Fixed the number of decimals shown for probability on the scale with the “toFixed” function.
4. Tool-tips for markings: re-used code used for tool-tips for the states, edited contents to use dataset signified by variable “d”.

1. Changed axes, with the Y-axis showing populations in units of 0.5 millions, and the X-axis showing number of deaths of a state.
2. Added male and female deaths and ratio to tool-tips.
3. Add a pan feature, where the axes are redrawn everytime the user pans (by dragging across the chart area), by using the “transform” function and redrawing the axes. This is evident in how the markings on the axes change upon movement in the chart area.
4. Added a zoom function to the markers for the states. This lets the user zoom in, pan, and then check the tool-tip, allowing a more detailed and granular view into the more crowded areas in the chart.

---

The map utilises a blue colourscheme now. The intensity of blue hues correlates directly with the assessed probability of death of an individual. The colour-scale denotes the extent of said probability across states. The encoding for cities now utilises a factor of the square of the respective radii instead of the original. Tooltips for the encoding for both states and cities now show male and female deaths separately to showcase the disparity in the number of deaths by gender in areas.
Coming to the graph - the X-axis quantifies the incidence of fatalities, whereas the Y-axis shows per states' population  as units of half a million. The shade of each circle acts to visualise the ratio of people killed by their gender in the particular state. A zoom and a pan feature have been implemented: the former allows for a more granular view of states which might seem to overlap in their colour and position in the graph, whilst the latter allows for movement of graph in varied conditions of being zoomed in or out. Finally, tool-tips for every circle in the encoding shows the state, as well as male and female deaths.

