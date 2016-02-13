# EventX
[![Code Climate](https://codeclimate.com/github/andela/eventx/badges/gpa.svg)](https://codeclimate.com/github/andela/eventx)
[![Test Coverage](https://codeclimate.com/github/andela/eventx/badges/coverage.svg)](https://codeclimate.com/github/andela/eventx/coverage)

What do you do when you have an event and all the event management applications available are too heavy but with little functionality to serve your purpose?
How do organize a small get-together with your friends, without having to go through a rigorous event creation process and without bothering about all the complexities of event management?
> Hmm!! If only there was an app for that? If only i could afford that application, if available?
So many wishes,really!

We created EventX for Event Managers who are not interested in the complexities of Event Management, but want to organize a world-class event!

## Features
Sleek and responsive interface,
Fluid event creation process,
Easy to use dashboard and
Single sign in, so you don't have to cram another password

The creation of EventX was a very interesting and challenging process.
In order to have one of the most robust and dependable applications, we had to collectively think through some of the most complex strategies and model abstractions.

Work is never ended on a great project, therefore we believe that this project will receive continous improvements/additions even as we create the most intuitive and innovative event management application.

#### Event Management.
Users who are event managers can create and manage their events on this platform. While creating an event, an event manager can create entry tickets for the event which can be purchased and downloaded from this platform.

On the event manager's dashboard, we have the statistics of the manager's events. Some of these statistics include:

* Number of tickets sold
* Number of tickets scanned at the event venue
* Total Amount of tickets sold
* Number of registered staff per event
* List of all events created by the manager.

The event manager can also add staff members to the platform and delegate tasks to them. These staff members have various authority level as to what they can do on the platform as set by the event manager.

Events are displayed in cards on the platforms. They are displayed in categories such as:

* Popular Events
* Recent Events
* Upcoming Events

Also, they can be displayed according to their types such as:

* Sports
* Parties
* Classes
* Music
* Arts ........ and so on.

#### Event Card

The event card contains the event's banner, the event's name, location and price. If a user is already attending an event, the price badge will show "ATTENDING" instead of the price.

#### Events Details
Details of events can be viewed by clicking on the event card. The details page shows more information about the event, such as:

* Event name
* Event start and end date
* Countdown timer to the event start date if the event hasn't started
* "Event has ended" message if the event has ended.
* ATTEND/UNATTEND button
* Social share buttons
* Event's description
* Map showing the event location
* Event Manager's details at the footer.
* A list of attendees

#### Ticket Management
Tickets can be sold and bought on EventX. Event mangers can create tickets while creating an event. The manager can also set the ticket price, the number of available tickets and the ticket name ( incase there is more than one ticket ).

Paid tickets can be bought by paying on PayPal. After purchase, the tickets will be available for download on the user's account page. Also users can download free tickets from this same page.

Each ticket comes with a QR code which can be scanned to check its validity. This will require a third party application which will consume the ticket's <a href ="#">Application Program Interface(API)</a>. This can be used to validate every ticket at the event entry point.

#### Attending An Event

A user can attend an event by clicking on the event card and clicking on **"ATTEND"**. After this, the ticket window will pup up, this will enable the user to select the type of ticket he/she wants. If its a free event, the user will select the free ticket and submit. If the attendance is successful, The **ATTEND** button will change to **UNATTEND**. The ticket will be available for download on the user's account page.

If the event is a paid event, the user will be redirected to PayPal after clicking **ATTEND** And selecting the ticket type from the pup up. After successful payment, the ticket will be available for download on the user's account page.  

#### Canceling An Event

The Event manager who wishes to cancel an event can do so from the event manager's dashboard. Selecting the **DISABLE** option for an event makes the event canceled. Disabled events can however be re-enabled at any time to make the event live again.

#### Searching Events
Events can be searched by its name, location, by date or by the combination of the three parameters.
The date option comes in:
* Today
* Tomorrow
* This Week
* This Weekend
* Next Week
* Next Weekend


## Check out Event X

 Check out the hosted version of this app at <a href="http://eventtx.com" target="blank">www.eventtx.com</a>
