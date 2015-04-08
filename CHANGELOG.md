## 1.0.7 - 2015-04-08
 * Merge pull request #26 from cbitstech/ems-91544146-standardize-date-and-datetimes
 * Update Time output format.
 * Update membership show and membership creation pages.

## 1.0.6 - 2015-04-06
 * Merge pull request #25 from cbitstech/ecf_91405400_participant_passwords
 * allow Researcher to set password for Participant
 * Merge pull request #24 from cbitstech/ems-91623394-update-projected-end-date-logic
 * Fix rubocop.
 * Use i18n format specification.
 * Make projected end date more accurate.

## 1.0.5 - 2015-03-26
 * Merge pull request #23 from cbitstech/ems-91010606
 * Fix membership form bug.

## 1.0.4 - 2015-03-23
 * Merge pull request #22 from cbitstech/gs-eager-load-groups-arms
 * Eager load groups when showing arms index
 * Merge pull request #21 from cbitstech/ems-90648642-social-membership-display-name
 * Update social membership creation.

## 1.0.3 - 2015-03-18
 * Merge pull request #20 from cbitstech/ems-90633568-add-disclaimer-for-refresh-on-reports
 * Update reports disclaimer.
 * Merge pull request #19 from cbitstech/jah_90116542_report_exception_message
 * Handle missing report

## 1.0.2 - 2015-03-13
 * Merge pull request #18 from cbitstech/ems-90111634-fix-group-dash-access
 * Remove button for non-social.

## 1.0.1 - 2015-03-12
 * Merge pull request #17 from cbitstech/ems-90111634-only-allow-social-arms-access-to-group-dash
 * Remove group dash button of non-social arms.

## 1.0.0 - 2015-03-11
 * Merge pull request #16 from cbitstech/JAH-batch_reports
 * refactor reporter controller code
 * Moved social reports to social networking
 * refactor reports controller
 * Generate batch reports

## 0.15.9 - 2015-03-10
 * Update git_tagger gem.
 * Merge pull request #15 from cbitstech/ems-86571058-add-goal-and-like-content-to-reports
 * Add fields to reports.

## 0.15.8 - 2015-03-04
 * Added button for group dashboard, fixed a bug with the group assignment start date, added specs

## 0.15.7 - 2015-03-02
 * Fixed validation message for study id of participant

## 0.15.6 - 2015-02-25
 * remove unnecessary user_agent_parser dependency
 * remove reports and refactor reports controller
 * Ensure group is assigned before coach can be assigned

## 0.15.5 - 2015-02-23
 * remove social reports and refactor controller

## 0.15.4 - 2015-02-23
 * moved some reports out of dashboard engine

## 0.15.2 - 2015-02-16
 * Generalize coach assignment flash messages
 * Expand coach/moderator assignment condtion to inlcude all social arms

## 0.15.1 - 2015-02-13
 * remove moderator class
 * add migration to drop tfd moderator table

## 0.15.0 - 2015-02-13
 * add Bootstrap breadcrumbs to dashboard pages
 * updated Travis configuration
 * enables dashboard to use host apps' layouts

## 0.14.2 - 2015-02-12
 * replaces all instances of coach language with coach/moderator language

## 0.14.1 - 2015-02-11
 * WAI assessment report bug fixes
 * membership active badge logic updated

## 0.14.0 - 2015-02-09
 * enable Wai Assessment export
 * removed moderator feature for non-social host applications
 * Latest version & Moderator field displays Moderator/Coach
 * Moderator field displays Moderator/Coach

## 0.13.11 - 2015-02-06
 * Moderator field displays Moderator/Coach

## 0.13.10 - 2015-02-06
 * fixed membership end date updating logic to fail saving past dates

## 0.13.9 - 2015-02-06
 * updated spec_helper and rails_helper to be specific to their individual needs

## 0.13.8 - 2015-02-05
 * change 'admin' to 'super user'
 * new label when a display name doesn't exist

## 0.13.7 - 2015-02-05
 * Updated display name "none" to "N/A"

## 0.13.6 - 2015-02-03
 * fixed spelling mistake

## 0.13.5 - 2015-02-03
 * Updated whether display is show on forms and show pages

## 0.13.4 - 2015-02-03
 * added a class to generate phq9 reports for researcher user
 * Removed unnecessary 'actions' div wrapper around submit buttons

## 0.13.3 - 2015-01-29
 * no longer displays Display Name fields and info if the app is not social.

## 0.13.2 - 2015-01-29
 * Button text to visit Patient Dashboard was renamed to Patient Dashboard from Patients

## 0.13.1 - 2015-01-28
 * updated membership creation view
 * refactored stylesheets

## 0.13.0 - 2015-01-28
 * prevent updating a Membership's group association

## 0.12.3 - 2015-01-28
 * Fixes bug in validating a participant's membership

## 0.12.2 - 2015-01-27
 * removes the main id attached to body along with updates tests to no longer use with_scope and removes feature helper file

## 0.12.1 - 2015-01-27
 * includes an app-level config method determining if parts of a view are visible when the host app has social capabilities

## 0.12.0 - 2015-01-27
 * removed inline style
 * removed unnecessary stylesheets, scripts, gems

## 0.11.8 - 2015-01-23
 * added logic to coach selection for woz arm participants.

## 0.11.7 - 2015-01-20
 * updated default study id for a moderating participant

## 0.11.6 - 2015-01-20
 * constant can now be used to set duration of moderating participant's membership

## 0.11.5 - 2015-01-16
 * added content to Reports

## 0.11.4 - 2015-01-16
 * updated git_tagger

## 0.11.3 - 2015-01-16
 * updated Gemlock reference
 
## 0.11.2 - 2015-01-16
 * updated the length a moderator exists for a group when created, add tagging gem

### 0.11.1
 * Report namespace bug fix

### 0.11.0

 * added reports

### 0.10.2 - 2014-1-7

* bug fixes
  * new Gemfile.lock file because of error on moodtech: https://github.com/cbitstech/think_feel_do_dashboard.git (at 0.10.1) is not yet checked out. Run `bundle install` first. (Bundler::GitError)

### 0.10.1 - 2014-1-7

* bug fixes
  * now correctly handling expections that are thrown in the Group class when a moderating participant is created

### 0.10.0

  * added Reports
  * updated deprecated RSpec syntax

### 0.9.2 - 2014-12-30

* enhancements
  * now handling expections that are thrown in the Group class when a moderating participant is created

### 0.9.1 - 2014-12-30

* enhancements
  * removed think_feel_do_engine, bit_core, and bit_player dependencies

### 0.9.0

* enhancements
  * added Login and Tool Share reports

### 0.8.1

* enhancements
  * added auth and specs to ProfileQuestion CRUD

### 0.8.0

* enhancements
  * implemented ProfileQuestion CRUD

### 0.7.8 - 2014-12-19

* bug fix
  * commented back in uncommented gem

### 0.7.7 - 2014-12-19

* bug fix
  * super users can now view patients link

### 0.7.6 - 2014-12-19

* enhancements
  * updated think_feel_do_engine

### 0.7.5 - 2014-12-19

* bug fixes
  * updated the authorization veiw of whether a reasearcher should view the 'Patients' link

### 0.7.4 - 2014-12-19

* enhancements
  * added additional tests for checking if moderator can be accessed from group page

### 0.7.3 - 2014-12-19

* enhancements
  * updated think_feel_do_engine gem

### 0.7.2

  * removed redundant/buggy view markup

### 0.7.1 - 2014-12-19

* enhancements
  * fixed with rubocop

### 0.7.0 - 2014-12-18

* enhancements
  * all patient funcationality is scoped within arms

### 0.6.3

  * conditionally display Group Moderator info

### 0.6.2

  * completed refactor to move Report classes

### 0.6.1

  * refactored Participant Concern into 2 Concerns

### 0.6.0 - 2014-12-17

* enhancements
  * added auto-generation of SocialNetworking::Profiles on group and group_moderator creation
  * Fixed merge conflict with a pull from 0.5.14

### 0.5.14 - 2014-12-17

* bug fixes
  * Removed bad migration
  * Updated validations for moderator on a group

### 0.5.13 - 2014-12-17

* enhancements
  * Updated (b/c of authorization) views with the latest ability.rb - from think_feel_do_engine

### 0.5.12 - 2014-12-16

* enhancements
  * Moved moderator actions - routes, views, actions - from think_feel_do_engine into engine

### 0.5.11 - 2014-12-16

* bug fixes
  * fixed merge conflicts

### 0.5.10 - 2014-12-16

* enhancements
  * updated membership creation to validate the participant being assigned.

### 0.5.9 - 2014-12-16

* enhancements
  * added in moderator validations from think_feel_do_engine
  * updated redirects after participant creation

### 0.5.8 - 2014-12-15

* enhancements
  * improved validations by placing them in the membership and participant model

### 0.5.7 - 2014-12-08

* enhancements
  * updated think_feel_do_engine

### 0.5.6 - 2014-12-05

* enhancements
  * updated engine think_feel_do_engine

### 0.5.5 - 2014-12-05

* enhancements
  * Using the latest ability.rb file from think_feel_do_engine

### 0.5.4 - 2014-12-04

* enhancements
  * updated participants fixtures and dummy app participant model


### 0.5.3 - 2014-12-03

* bugfixes
  * modified Password concern to only validate on create
  * updated specs for user/participant creation and password concern

### 0.5.2 - 2014-12-02

* enhancements
  * updated engine think_feel_do_engine and the corresponding routes

### 0.5.1 - 2014-12-02

* bugfixes
  * Removed conflicting migrations that are already included in think_feel_do_engine

### 0.5.0 - 2014-12-01

* enhancements
  * Renamed 'Admin' to Super User in forms, show pages, and index pages

### 0.4.6 - 2014-11-26

* enhancements
  * removed null constrating (it is added later)
  * removed commented code

### 0.4.5 - 2014-11-26

* enhancements
  * Added devise gem to verify authentication
  * removed password and password confirmation columns from User model in spec/dummy/app/models/user.rb
  * Added UserRole class and updated specs to log in with correct UserRole

### 0.4.4 - 2014-11-25

* bugfixes
  * After a user edit's their profile, they signed back in automatically

### 0.4.3 - 2014-11-25

* enhancements
  * Updated to latest think_feel_do_engine

### 0.4.2 - 2014-11-25

* enhancements
  * Merged in migration changes dealing with removing migration from this engine that removed arm_id from group (note: if this migration is later than the host application migration, there may be a conflict)
  * Added in 'Sign Out' link if user is logged in.

### 0.4.1 - 2014-11-24

* enhancements
  * Updated think_feel_do_engine gem in order to display the correct Home and NavBrand links
  * Added "Research Dashboard" to the views in order to clear up navigation

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
