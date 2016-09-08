cd module

string="
saveTabGroup(String tabgroup, String callback) {
  Boolean enableAutosave      = true;
  String  id                  = getUuid(tabgroup);
  List    geometry            = null;
  List    attributes          = null;
  String  parentTabgroup_     = parentTabgroup;
  String  parentTabgroupUuid_ = getUuid(parentTabgroup_);
  Boolean userWasSet          = !username.equals(\"\");

  String repopulateEntityList;
  repopulateEntityList = \"populateEntityListsInTabGroup(\\\"{tabGroup}\\\")\";
  repopulateEntityList = replaceFirst(repopulateEntityList, \"{tabGroup}\", parentTabgroup__);

  callback = repopulateEntityList + \";\" + callback;

  parentTabgroup = null;

  SaveCallback saveCallback  = new SaveCallback() {
    onSave(uuid, newRecord) {
      setUuid(tabgroup, uuid);
      \/\/ Make a child-parent relationship if need be.
      if (
          newRecord &&
          !isNull(parentTabgroup_) &&
          !isNull(parentTabgroupUuid_)
      ) {
        String rel = \"\";
        rel += parentTabgroup_.replaceAll(\"_\", \" \");
        rel += \" - \";
        rel += tabgroup.replaceAll(\"_\", \" \");
        saveEntitiesToHierRel(
          rel,
          parentTabgroupUuid_,
          uuid,
          \"Parent Of\",
          \"Child Of\",
          callback
        );
      } else {
        execute(callback);
      }

      \/\/ This fixes an interesting bug. Without this, if a user was not set
      \/\/ (by calling \`setUser\`) at the time \`saveTabGroup\` was first called, but
      \/\/ set by the time \`onSave\` was called, the tab group is saved correctly
      \/\/ the first time only.
      \/\/
      \/\/ Adding this allows subsequent saves to succeed. Presumably it plays
      \/\/ some role in helping FAIMS associate the correct user with a record.
      if (!userWasSet) {
        saveTabGroup(tabgroup, callback);
      }

    }
    onError(message) {
      showToast(message);
    }
  };

  saveTabGroup(tabgroup, id, geometry, attributes, saveCallback, enableAutosave);
}"
replacement=""
perl -0777 -i.original -pe "s/\\Q$string/$replacement/igs" ui_logic.bsh

rm ui_logic.bsh.original
