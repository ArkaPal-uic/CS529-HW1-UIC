# CS529-HW1-UIC

## Visualisation made "White-hat"

A few ways in which the new visualisations better the "Blackhat" visualisations are:

The map (`Whitehat.js`) utilises a blue colour scheme. The intensity of blue hues correlates directly with the assessed probability of death of an individual. The colour-scale denotes the extent of said probability across states. Tool-tips for the encoding for both states and cities now show male and female deaths separately to showcase the disparity in the number of deaths by gender in areas.

The graph (`WhiteHatStats.js`) represents a grouped bar chart displaying Male and Female deaths for each state. The X-axis represents state abbreviations, whilst the Y-axis contains the minimum to the maximum number of deaths across states. Tool-tips provide the specific number of Male or Female deaths and the percentage of deaths of a gender with respect to the total death count. Code for Tool-tips were repurposed from `Whitehat.js`.

## Whitehat.js
1. Blue colour: using `d3.interpolateBlues`
2. To coordinate colour with probability: utilised variable `stateCountsDeaths` and mapped the interpolation with it.
3. To keep scale consistent with map: Fixed the number of decimals shown for probability on the scale with the `toFixed` function.
4. Tool-tips for markings: re-used code used for tool-tips for the states, edited contents to use dataset signified by variable `d`.

## WhiteHatStats.js

1. Created a grouped bar chart with Male and Female deaths in every state.
2. The X axis shows the abbreviation (`d.abbreviation`) for each state whilst the Y axis (goes from the minimum to the maximum number of deaths across all states) shows the range of the number of deaths.
3. Each tool-tip contains the relevant number of deaths (Male or female) and the percentage of deaths of a gender from the total death count.
4. Re-used the code snippets for tool-tips from `Whitehat.js`.

---

### Resources for Grouped Bar chart:
- https://d3-graph-gallery.com/graph/barplot_grouped_basicWide.html
- https://dataviz.unhcr.org/tools/d3/d3_grouped_bar_chart.html
- https://observablehq.com/@d3/grouped-bar-chart/2
- https://vaibhavkumar-19430.medium.com/how-to-create-a-grouped-bar-chart-in-d3-js-232c54f85894

---

### Due credit to materials from assignment declaration:

- State map: https://eric.clst.org/tech/usgeojson/
- Original state population: US Census
    - https://www.census.gov/data/tables/time-series/demo/popest/2010s-state-total.html
- Original Slate gun violence dataset: https://www.slate.com/articles/news_and_politics/crime/2012/12/gun_death_tally_every_american_gun_death_since_newtown_sandy_hook_shooting.html
- Andrew Wentzel for the template of code provided for this assignment.

---

![Image](https://github.com/ArkaPal-uic/CS529HW1/blob/f2084628becc9899561f92b82cd4d874c0901ea2/HW1.png)
