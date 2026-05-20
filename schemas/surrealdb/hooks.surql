DEFINE TABLE hook_event SCHEMAFULL;

DEFINE FIELD hook_type ON TABLE hook_event TYPE string;
DEFINE FIELD source ON TABLE hook_event TYPE string;
DEFINE FIELD target ON TABLE hook_event TYPE string;
DEFINE FIELD workflow_id ON TABLE hook_event FLEXIBLE TYPE option<string>;
DEFINE FIELD run_id ON TABLE hook_event FLEXIBLE TYPE option<string>;
DEFINE FIELD payload ON TABLE hook_event TYPE object;
DEFINE FIELD status ON TABLE hook_event TYPE string;
DEFINE FIELD decision_required ON TABLE hook_event TYPE bool DEFAULT false;
DEFINE FIELD decision ON TABLE hook_event FLEXIBLE TYPE option<object>;
DEFINE FIELD created_at ON TABLE hook_event TYPE datetime VALUE time::now();
DEFINE FIELD processed_at ON TABLE hook_event FLEXIBLE TYPE option<datetime>;

DEFINE INDEX hook_event_type_idx ON TABLE hook_event FIELDS hook_type;
DEFINE INDEX hook_event_status_idx ON TABLE hook_event FIELDS status;
DEFINE INDEX hook_event_run_idx ON TABLE hook_event FIELDS run_id;
