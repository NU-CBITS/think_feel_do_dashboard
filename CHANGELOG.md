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