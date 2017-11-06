# List of Tables



| Name | Description |
|------|-------------|
| assessment_actions | This table stores the interactions of the user with the assessment. |
| assessment_assessments_questions | Link table between the assessment and the questions data and describe high-level information of questions in an assessment. |
| assessment_checkbox_questions | Information of checkbox quiz questions |
| assessment_checkbox_reflect_questions | Information of checkbox(Reflective / Ungraded) quiz questions |
| assessment_math_expression_patterns | the patterns of the answers to a math assessment question |
| assessment_math_expression_questions | math assessment questions and default text displayed to learners upon answering the questions incorrectly |
| assessment_mcq_questions | multiple-choice assessment questions |
| assessment_mcq_reflect_questions | Information of (Reflective / Ungraded) Multiple Choice Questions |
| assessment_options | Information of choice options for a question |
| assessment_pattern_flag_types | Information on pattern flag types |
| assessment_pattern_types | Info on pattern matching questions: Text Answer, Numeric, Regular Expression, and Math Expression |
| assessment_question_types | Description of the types of quiz questions |
| assessment_questions | Information of quiz questions |
| assessment_reflect_questions | Information of ungraded text entry question |
| assessment_regex_pattern_flags | [No table description available] |
| assessment_regex_patterns | [No table description available] |
| assessment_regex_questions | [No table description available] |
| assessment_response_options | learner responses to assessments |
| assessment_response_patterns | [No table description available] |
| assessment_responses | information of learner responses to a quiz question and the score received |
| assessment_scope_types | The description of the varying contexts in which the user can interact with the assessment |
| assessment_single_numeric_patterns | Table that stores the single numeric pattern type questions. |
| assessment_single_numeric_questions | Information of single numeric (Numeric match) questions |
| assessment_text_exact_match_patterns | [No table description available] |
| assessment_text_exact_match_questions | Information of text exact match questions |
| assessment_types | Description of assessment types |
| assessments | Table of all the assessments / quizzes. |
| course_branch_grades | This table provides the grading event of when the user reached his or her highest grade in one course branch. Also provides the passing/not-passing state for each user and course branch. |
| course_branch_item_assessments | For each course branch, provide the mapping between course branches and versioned assessments. |
| course_branch_item_peer_assignments | For each course, provide the mapping between course branches and versioned peer assignments. |
| course_branch_item_programming_assignments | For each course, provide the mapping between course branches and versioned programming assignments. |
| course_branch_items | A single content item in a class such as lecture, quiz or peer review assignment. |
| course_branch_lessons | Subsection of a single module, can be composed of multiple items in a course. |
| course_branch_modules | [No table description available] |
| course_branches | This table gives the course branch details along with course version names, as set by instructors on the course web page. |
| course_formative_quiz_grades | Grades of a single user in each of the ungraded quizzes. |
| course_grades | This table provides the grading event of when the user reached his or her highest grade in one course (of any branch of the course, see course_branch_grades for specific branch grades). Also provides the passing/not-passing state for each user and course. |
| course_item_assessments | For each course, provide the mapping between course items and versioned assessments. |
| course_item_grades | Grades of user for each of the items in the course |
| course_item_passing_states | Each item in a course can be in one of three "states" with respect a learner passing the item. |
| course_item_peer_assignments | For each course, provide the mapping between course items and versioned peer assignments. |
| course_item_programming_assignments | For each course, provide the mapping between course items and versioned programming assignments. |
| course_item_types | There are many different types of of items that make up a course. Each item is given an item_type_id for ease of identification. |
| course_items | A single content item in a course such as lecture, quiz or peer review assignment. Note: For courses that uses the Course Versioning feature, please refer to the branch version of this table. |
| course_lessons | Subsection of a single module, can be composed of multiple items in a course. Note: For courses that uses the Course Versioning feature, please refer to the branch version of this table. |
| course_memberships | A log of when and what membership role did a user get assigned to for a course. A <user_id, course_id> tuple can have multiple values in this table to record the different roles across time. For example, a learner could have watched the preview content (BROWSER), then hit the enroll button to join (LEARNER), and then unenrolled a few days later (NOT_ENROLLED). |
| course_modules | Contains each course's set of modules, their names, their description, and their order. Note: For courses that use the Course Versioning feature, please refer to the branch version of this table. |
| course_passing_states | The descriptions of passing states for courses from the course_grades table |
| course_progress | Contains a log of when and how a user progresses in one course item of a course, with one of two progress states: 'started' or 'completed' |
| course_progress_state_types | A mapping table from ids to descriptions of the different course progress states, such as 1 meaning "started". |
| courses | The list of Coursera's courses on the Phoenix platform, including info on its important dates (e.g. when it was launched) |
| demographics_answers | Stores answers to the questions from the demographics survey and user intent questions. |
| demographics_choices | Stores choices to the questions from the demographics survey and user intent questions. |
| demographics_question_types | Stores question types for the demographics questions. |
| demographics_questions | Stores questions from the demographics survey and user intent questions. |
| discussion_answer_flags | records when a discussion answer is marked as resolved. |
| discussion_answer_votes | records when a discussion answer was upvoted or revoked. |
| discussion_answers | For each course's discussion forums, contains the list of the answers that users submitted to discussion questions. |
| discussion_course_forums | The list of course forums. Every course branch has one root forum. Also, week and item forums are created based on the course material. |
| discussion_question_flags | records when an discussion question is flagged as resolved |
| discussion_question_followings | records when discussion question is followed or unfollowed |
| discussion_question_votes | records when a discussion question was upvoted |
| discussion_questions | For each course's discussion forums, contains the list of the questions, with its title, content, and author. |
| ecb_engines | Executable code block engines handle evaluation requests for a single language. |
| ecb_evaluation_requests | Executable code block evaluations requested by learners. |
| ecb_evaluators | Executable code block evaluators define how input from learners will be evaluated. At a high level, evaluators include a reference to a language-specific 'engine', and a 'harness' definition that parameterizes the execution mode - for example graded feedback vs. simple execution. |
| feedback_course_comments | Contains the contents of course reviews |
| feedback_course_ratings | Contains data for course ratings |
| feedback_item_comments | Contains the contents of comments on items or sub-items, which should generally be flags |
| feedback_item_ratings | Contains data for item-level ratings |
| jhu_course_user_ids | Encrypted user id mapping table. Use this table to connect learner data from exports, which identifies jhu learners using jhu_user_id, to course-scoped data from external surveys. |
| notebook_workspace_launchers | [No table description available] |
| notebook_workspaces | Notebook workspace provide a user with access to a Jupyter server with a persistent file system that stores personal files. |
| on_demand_session_memberships | For each course's session, list the learners with the role of 'member' in that session and their start/end timestamps |
| on_demand_sessions | Contains sessions info (e.g start and end dates) and the Course Versioning used on the Phoenix platform |
| peer_assignment_review_schema_part_options | The options for review schema parts that have options |
| peer_assignment_review_schema_parts | The questions that the reviewer must answer |
| peer_assignment_submission_schema_parts | The questions that a submitter must answer in their submission |
| peer_assignments | Metadata of peer assignments |
| peer_comments | Peer comments on submissions |
| peer_review_part_choices | Answers to option-based review schema questions ("options" and "yesNo") |
| peer_review_part_free_responses | Answers to free response review schema questions ("singleLineInput" and "multiLineInput") |
| peer_reviews | The reviews that reviewers have made for submissions |
| peer_skips | Users may "skip" reviewing a submission if there is a problem with it. This table records all the skips that happen. |
| peer_submission_part_free_responses | Answers to the submission schema questions, for the "plainText" and "richText" submission schema part types. |
| peer_submission_part_scores | Part scores that a submission gets. This only exists for submissions that have scores. |
| peer_submission_part_urls | Answers to the submission schema questions, for the "fileUpload" and "url" submission schema part types |
| peer_submissions | Submissions to peer assignments. Caveats: This table contains public submissions, draft submissions, and deleted submissions. Use the peer_submission_is_draft and peer_submission_has_been_removed_from_public columns to disambiguate |
| programming_assignment_submission_schema_part_grid_schemas | Information of asynchronously graded parts of programming assignments |
| programming_assignment_submission_schema_part_possible_responses | possible correct responses to a part of a programming assignment. Name shortened from 'programming_assignment_submission_schema_part_possible_responses' for compatibility. |
| programming_assignment_submission_schema_parts | Information of individual parts of a programming assignment |
| programming_assignments | Information of programming assignments |
| programming_submission_part_evaluations | scores of individual parts of a programming assignment |
| programming_submission_part_grid_grading_statuses | The status of grading of a submission to an asynchronously graded question |
| programming_submission_part_grid_submissions | Submissions to asynchronously graded questions |
| programming_submission_part_text_submissions | learner submissions to synchronously graded questions of a programming assignment |
| programming_submission_parts | Information of learner submissions to individual parts of a programming assignment |
| programming_submissions | submissions of a programming assignment |
| users | Information about Coursera users |
| users_courses__certificate_payments | [No table description available] |
