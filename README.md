# Project 2 - Yelpy

*Yelpy* is a Yelp search app using the [Yelp API](http://www.yelp.com/developers/documentation/v2/search_api).

Time spent: *9* hours spent in total

## User Stories

The following **required** functionality is completed:

- [X] Search results page
   - [X] Table rows should be dynamic height according to the content height.
   - [X] Custom cells should have the proper Auto Layout constraints.
   - [X] Search bar should be in the navigation bar (doesn't have to expand to show location like the real Yelp app does).
- [X] Filter page. Unfortunately, not all the filters are supported in the Yelp API.
   - [X] The filters you should actually have are: category, sort (best match, distance, highest rated), distance, deals (on/off).
   - [X] The filters table should be organized into sections as in the mock.
   - [X] You can use the default UISwitch for on/off states.
   - [X] Clicking on the "Search" button should dismiss the filters page and trigger the search w/ the new filter settings.

The following **optional** features are implemented:

- [X] Search results page
   - [X] Infinite scroll for restaurant results.
   - [X] Implement map view of restaurant results.
- [X] Filter page
   - [X] Implement a custom switch instead of the default UISwitch. I implemented this by adding images and labels for on and off states respectively directly in the FiltersCell and manipulating these views via isHidden. The next step will be to extract these views into a subclass of UISwitch class. 
   - [X] Distance filter should expand as in the real Yelp app
   - [X] Categories should show a subset of the full list with a "See All" row to expand. Category list is [here](http://www.yelp.com/developers/documentation/category_list).
- [X] Implement the restaurant detail page.

The following **additional** features are implemented:

- [X] Added ability to call the business from the Details page
- [X] Added ability to get driving directions to the business from the Details page

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1.In general would like to learn the best practices on how to handle images or resize them correctly for 2x/3x. Especially for images downloaded from the internet.
2.Didnt quite figure out the best way to make custom table view cells have a shorter width than the tableview. In the end just ended up shortening the tableview width to get the "inset" effect on cells.
3.As mentioned above in the optional section, i implemented the sort of a custom UISwitch by adding views directly to the custom cell, not ideal but get the expected UI effect. Next step is to subclass UISwitch and add this funtionality into it.
## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src='https://i.imgur.com/1bbCEf4.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes


## License

    Copyright 2017 Kavita Gaitonde

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
