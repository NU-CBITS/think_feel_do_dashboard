### 0.4.0 - 2014-11-21

* enhancements
  * Removed projects table and model because they are no longer necessary for scoping

### 0.3.2 - 2014-11-20

* bugfixes
  * Commented out default time zone of "Central Time (US & Canada)" because it didn't solve the error on travis

### 0.3.1 - 2014-11-20

* bugfixes
  * Added default time zone of "Central Time (US & Canada)"

### 0.3.0 - 2014-11-20

* enhancements
  * Added arm_id to groups and removed ArmJoinGroup
  * Added foreign key validations to groups and arms
  * Removed Arms and Projects from this project and made them a dependency b/c they are used now in multiple engines
  * Update forms and views to include arm_ids and project_ids
  * Updated toolbars and added role
  * Updated fixtures and specs
  * Updated readme

### 0.2.1 - 2014-11-20

* enhancements
  * Updated to be compatible with rails 4.1.8

### 0.2.0 - 2014-11-19

* enhancements
  * Updated toolbars and added role
  * Improved navigation to host applications by adding ThinkFeelDo link and added references to arms path in the host application
  * Reordered homepage for improved clarification along with removing navigation links
  * Updated spec dummy (i.e., routes.rb) to mimic more closely the host application
  * Changed semantics on buttons and headers for easier navigation from host app

### 0.1.0 - 2014-11-14

* enhancements
  * Moved reports controller and views into this gem.  Therefore, researches now have access to download CSV reports through this engine.

### 0.0.9 - 2014-11-13

* enhancements
  * Updated sass related gems
  * Changed application.css extension
  * Updated app/config/initialize/assets.rb file so local css and js are precompiled"

* bugfixes
  * Application no longer fails on Travis

### 0.0.8 - 2014-11-13

* bugfixes
  * Added back in authentication

### 0.0.7 - 2014-11-13

* enhancements
  * Updated the participant's profile page.
  * Finished how enrollments is completed for participants.
  * Add validation for "display name" on participant updating that now determines if an arm is associated.
  * Display study_id of a participant instead of email and made this a concern that is added to participant model, if it isn't already included.
  * Updated the participant show page.
* bugfixes
  * Switch label text for "is social?"
  * If no groups exist you cannot edit participant is now possible do to the change in work flow.

### 0.0.6 - 2014-11-12

* enhancements
  * Changed the formatting of participant phone numbers by adding area code.

### 0.0.5 - 2014-11-12

* enhancements
  * Improved formatting of the display of phone numbers.

### 0.0.4 - 2014-11-12

* enhancements
  * Using study id to identify participants instead of emails
  * Removed enrollments controller and work flow.  Memberships and coachers are now managed independently from the participant page
* bugfixes
  * Fixed the label name used to display which arms were social and which were mobile.