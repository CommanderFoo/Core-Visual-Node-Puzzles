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
  ChildIds: 5768206974450963472
  ChildIds: 15235961953144066896
  ChildIds: 16099356608972045403
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
      Name: "cs:ui_container"
      ObjectReference {
        SelfId: 3627026760658224672
      }
    }
    Overrides {
      Name: "cs:puzzle_1"
      AssetReference {
        Id: 18342310647756492933
      }
    }
    Overrides {
      Name: "cs:puzzle_2"
      AssetReference {
        Id: 10469967699431797903
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
  Name: "Puzzle_Manager_Client"
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
      Name: "cs:data"
      ObjectReference {
        SelfId: 3720954960903579450
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
      Id: 12955436264733002318
    }
  }
}
Objects {
  Id: 5768206974450963472
  Name: "Setup_Client"
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
      Id: 6862747020204020962
    }
  }
}
