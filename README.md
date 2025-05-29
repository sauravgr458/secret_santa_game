# Secret Santa Assignment App

Overview
--------

This Rails application implements a Secret Santa assignment system. It accepts a CSV input of participants and assigns gift givers and receivers while respecting constraints such as:

*   No participant is assigned to themselves.
    
*   No participant is assigned to their spouse or partner.
    
*   All participants are matched fairly, including RAC and waiting list logic if applicable.
    

Getting Started
---------------

### Prerequisites

*   Ruby 3.2.2
    
*   Rails 7.1.5
    
*   Bundler
    

### Setup

1.  git clone git@github.com:sauravgr458/secret\_santa\_game.git
    
2.  cd secret\_santa\_game
    
3.  bundle install
    

Uploading Participants CSV
--------------------------

*   Use the provided web UI form (/participants/new) to upload a CSV file.
    
*   name,email,spouseAlice,alice@example.com,BobBob,bob@example.com,AliceCharlie,charlie@example.com,...
    

Running the Assignment
----------------------

*   rake secret\_santa:assign
    
*   This task will:
    
    *   Parse the uploaded CSV file.
        
    *   Validate participants and constraints.
        
    *   Generate assignments.
        
    *   Output the results in assignments.csv or display them on the UI.
        

Testing
-------

### RSpec Tests

Run the test suite with:
`   bundle exec rspec   `

Tests cover:

*   CSV parsing and validation
    
*   Assignment logic ensuring no one is assigned to themselves or spouses
    
*   Edge cases and error handling
    

### Rake Tasks

*   rake secret\_santa:assign — performs the assignment.
    
*   Other tasks may be available for cleaning or seeding data.
    

Assignment Logic Summary
------------------------

*   Each participant is assigned a gift recipient such that:
    
    *   No participant is assigned to themselves.
        
    *   Spouses or partners are excluded from each other’s assignment.
        
    *   The assignment is randomized but fair and respects all constraints.
        
*   The system raises errors or warnings if the input data makes a valid assignment impossible.
    

Error Handling
--------------

*   Invalid CSVs or participant data will return user-friendly error messages.
    
*   Errors are logged and displayed in the UI or console for debugging.
    

Contributing
------------

Feel free to submit issues or pull requests to improve the logic.
