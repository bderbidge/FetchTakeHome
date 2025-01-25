### Summary: Include screen shots or a video of your app highlighting its features
#### List View
<p float="left">
<img src="https://github.com/bderbidge/FetchTakeHome/blob/main/Simulator%20Screenshot%20-%20iPhone%2016%20Pro%20-%202025-01-24%20at%2019.39.34.png" width="300">

#### Empty Screen
<img src="https://github.com/bderbidge/FetchTakeHome/blob/main/Simulator%20Screenshot%20-%20iPhone%2016%20Pro%20-%202025-01-24%20at%2018.57.45.png" width="300">

#### Error Screen
<img src="https://github.com/bderbidge/FetchTakeHome/blob/main/Simulator%20Screenshot%20-%20iPhone%2016%20Pro%20-%202025-01-24%20at%2018.57.40.png" width="300">
</p>

### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?
My main focus was on the Repository and ensuring the interactions between the web client and photo manager followed the single responsibility principle to ensure testability. Furthermore I spent time following protocol oriented programming as it allows the use of mocking and and dependency injection for cleaner code.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?
In total I spent about 3.5 hours on this project and the tests.
I spent 25% of my time on implementing the ui 
I spent 50% on on the Repository and web client and photo manager
I spent 25% on the tests

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?
The main decssion I made was around stale photos. Because the data isn't changing I didn't worry about implementing any sort of check to refresh the downloaded images. In a situation where I know that the images will be updated I would ensure some sort of check to ensure that the correct images are downloaded.
I could have implemented more on the ui however, I had a busy week and did not have the time to add filters or searching like I would have liked to.

### Weakest Part of the Project: What do you think is the weakest part of your project?
The decission I mention above is probably the weakest part of the project. If the images are updated on the backend then it will make the ones on the device stale. I also did not worry about image size or how much space on the device I was taking up on device. 

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.
