Name: "Scripts"
RootId: 5021637449606560396
Objects {
  Id: 917384028508757458
  Name: "Server Scripts"
  Transform {
    Location {
    }
    Rotation {
    }
    Scale {
      X: 1
      Y: 1
      Z: 1
    }
  }
  ParentId: 5021637449606560396
  ChildIds: 1419306634217875590
  Collidable_v2 {
    Value: "mc:ecollisionsetting:inheritfromparent"
  }
  Visible_v2 {
    Value: "mc:evisibilitysetting:inheritfromparent"
  }
  NetworkContext {
    Type: Server
  }
}
Objects {
  Id: 1419306634217875590
  Name: "Game_Manager_Server"
  Transform {
    Location {
    }
    Rotation {
    }
    Scale {
      X: 1
      Y: 1
      Z: 1
    }
  }
  ParentId: 917384028508757458
  UnregisteredParameters {
    Overrides {
      Name: "cs:data"
      ObjectReference {
        SelfId: 3720954960903579450
      }
    }
    Overrides {
      Name: "cs:clear_player_data"
      Bool: false
    }
  }
  Collidable_v2 {
    Value: "mc:ecollisionsetting:inheritfromparent"
  }
  Visible_v2 {
    Value: "mc:evisibilitysetting:inheritfromparent"
  }
  Script {
    ScriptAsset {
      Id: 15934012071480122557
    }
  }
}
Objects {
  Id: 2456857752610234367
  Name: "Client Scripts"
  Transform {
    Location {
    }
    Rotation {
    }
    Scale {
      X: 1
      Y: 1
      Z: 1
    }
  }
  ParentId: 5021637449606560396
  ChildIds: 15235961953144066896
  ChildIds: 16099356608972045403
  ChildIds: 12262875492945277035
  ChildIds: 225476450877697714
  Collidable_v2 {
    Value: "mc:ecollisionsetting:forceoff"
  }
  Visible_v2 {
    Value: "mc:evisibilitysetting:inheritfromparent"
  }
  NetworkContext {
  }
}
Objects {
  Id: 225476450877697714
  Name: "Music_Manager_Client"
  Transform {
    Location {
    }
    Rotation {
    }
    Scale {
      X: 1
      Y: 1
      Z: 1
    }
  }
  ParentId: 2456857752610234367
  UnregisteredParameters {
    Overrides {
      Name: "cs:music_folder"
      ObjectReference {
        SelfId: 17829228507645182166
      }
    }
  }
  Collidable_v2 {
    Value: "mc:ecollisionsetting:inheritfromparent"
  }
  Visible_v2 {
    Value: "mc:evisibilitysetting:inheritfromparent"
  }
  Script {
    ScriptAsset {
      Id: 14017043884502793907
    }
  }
}
Objects {
  Id: 12262875492945277035
  Name: "Header_Controls_Client"
  Transform {
    Location {
    }
    Rotation {
    }
    Scale {
      X: 1
      Y: 1
      Z: 1
    }
  }
  ParentId: 2456857752610234367
  UnregisteredParameters {
    Overrides {
      Name: "cs:slow_down_button"
      ObjectReference {
        SelfId: 1642271436328204440
      }
    }
    Overrides {
      Name: "cs:speed_up_button"
      ObjectReference {
        SelfId: 13792568079146887383
      }
    }
    Overrides {
      Name: "cs:current_speed"
      ObjectReference {
        SelfId: 16510564283218734217
      }
    }
    Overrides {
      Name: "cs:run_edit_button"
      ObjectReference {
        SelfId: 8014293986482026159
      }
    }
    Overrides {
      Name: "cs:available_nodes_button"
      ObjectReference {
        SelfId: 16498719261319731661
      }
    }
    Overrides {
      Name: "cs:available_nodes_container"
      ObjectReference {
        SelfId: 7410864171820395270
      }
    }
    Overrides {
      Name: "cs:gold_award"
      ObjectReference {
        SelfId: 17695944796071942173
        SubObjectId: 9123463160940538860
        InstanceId: 17578521251814157664
        TemplateId: 3563390086910122431
      }
    }
    Overrides {
      Name: "cs:silver_award"
      ObjectReference {
        SelfId: 4460568831204173262
        SubObjectId: 10307689033462092511
        InstanceId: 3938458423291239208
        TemplateId: 10438144223879621155
      }
    }
    Overrides {
      Name: "cs:bronze_award"
      ObjectReference {
        SelfId: 11699668853634421299
        SubObjectId: 17480121017144831975
        InstanceId: 3122469898748972966
        TemplateId: 4242474907989208124
      }
    }
    Overrides {
      Name: "cs:settings_button"
      ObjectReference {
        SelfId: 6420074902797676133
      }
    }
    Overrides {
      Name: "cs:settings"
      ObjectReference {
        SelfId: 14116838315011425361
      }
    }
  }
  Collidable_v2 {
    Value: "mc:ecollisionsetting:inheritfromparent"
  }
  Visible_v2 {
    Value: "mc:evisibilitysetting:inheritfromparent"
  }
  Script {
    ScriptAsset {
      Id: 9569902822382107857
    }
  }
}
Objects {
  Id: 16099356608972045403
  Name: "Puzzle_Loader_Client"
  Transform {
    Location {
    }
    Rotation {
    }
    Scale {
      X: 1
      Y: 1
      Z: 1
    }
  }
  ParentId: 2456857752610234367
  UnregisteredParameters {
    Overrides {
      Name: "cs:nodes_container"
      ObjectReference {
        SelfId: 7410864171820395270
      }
    }
    Overrides {
      Name: "cs:puzzle_name"
      ObjectReference {
        SelfId: 7400731441112918373
      }
    }
    Overrides {
      Name: "cs:data"
      ObjectReference {
        SelfId: 3720954960903579450
      }
    }
    Overrides {
      Name: "cs:tutorial_container"
      ObjectReference {
        SelfId: 6452927242494604331
      }
    }
    Overrides {
      Name: "cs:loading"
      ObjectReference {
        SelfId: 16860121657648772684
      }
    }
    Overrides {
      Name: "cs:puzzle_1"
      AssetReference {
        Id: 2907093068677695656
      }
    }
    Overrides {
      Name: "cs:puzzle_2"
      AssetReference {
        Id: 2264408178530052537
      }
    }
  }
  Collidable_v2 {
    Value: "mc:ecollisionsetting:inheritfromparent"
  }
  Visible_v2 {
    Value: "mc:evisibilitysetting:inheritfromparent"
  }
  Script {
    ScriptAsset {
      Id: 15350687835794600605
    }
  }
}
Objects {
  Id: 15235961953144066896
  Name: "Player_Client"
  Transform {
    Location {
    }
    Rotation {
    }
    Scale {
      X: 1
      Y: 1
      Z: 1
    }
  }
  ParentId: 2456857752610234367
  UnregisteredParameters {
  }
  Collidable_v2 {
    Value: "mc:ecollisionsetting:inheritfromparent"
  }
  Visible_v2 {
    Value: "mc:evisibilitysetting:inheritfromparent"
  }
  Script {
    ScriptAsset {
      Id: 12955436264733002318
    }
  }
}
