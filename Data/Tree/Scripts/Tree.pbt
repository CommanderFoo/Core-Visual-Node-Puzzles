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
  ChildIds: 15294849702650267166
  Collidable_v2 {
    Value: "mc:ecollisionsetting:inheritfromparent"
  }
  Visible_v2 {
    Value: "mc:evisibilitysetting:inheritfromparent"
  }
  CameraCollidable {
    Value: "mc:ecollisionsetting:inheritfromparent"
  }
  NetworkContext {
    Type: Server
  }
}
Objects {
  Id: 15294849702650267166
  Name: "Save_Data_Server"
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
      Name: "cs:YOOTIL"
      AssetReference {
        Id: 16622261663679835299
      }
    }
    Overrides {
      Name: "cs:puzzle_data"
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
  CameraCollidable {
    Value: "mc:ecollisionsetting:inheritfromparent"
  }
  Script {
    ScriptAsset {
      Id: 14589166436730816444
    }
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
    Overrides {
      Name: "cs:YOOTIL"
      AssetReference {
        Id: 16622261663679835299
      }
    }
    Overrides {
      Name: "cs:NodeUI"
      ObjectReference {
        SelfId: 3627026760658224672
      }
    }
  }
  Collidable_v2 {
    Value: "mc:ecollisionsetting:inheritfromparent"
  }
  Visible_v2 {
    Value: "mc:evisibilitysetting:inheritfromparent"
  }
  CameraCollidable {
    Value: "mc:ecollisionsetting:inheritfromparent"
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
  ChildIds: 8975716410678032075
  ChildIds: 2366539210659061100
  ChildIds: 8251904590631658214
  ChildIds: 2365147788075538306
  ChildIds: 15163209075878739494
  ChildIds: 6068750308711967726
  Collidable_v2 {
    Value: "mc:ecollisionsetting:forceoff"
  }
  Visible_v2 {
    Value: "mc:evisibilitysetting:inheritfromparent"
  }
  CameraCollidable {
    Value: "mc:ecollisionsetting:forceoff"
  }
  NetworkContext {
  }
}
Objects {
  Id: 6068750308711967726
  Name: "Save_Data_Client"
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
      Name: "cs:API"
      AssetReference {
        Id: 11355776926042268297
      }
    }
    Overrides {
      Name: "cs:puzzle_data"
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
  CameraCollidable {
    Value: "mc:ecollisionsetting:inheritfromparent"
  }
  Script {
    ScriptAsset {
      Id: 17326225549286146051
    }
  }
}
Objects {
  Id: 15163209075878739494
  Name: "Notification_Client"
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
      Name: "cs:YOOTIL"
      AssetReference {
        Id: 16622261663679835299
      }
    }
    Overrides {
      Name: "cs:notification"
      ObjectReference {
        SelfId: 12406843943296698370
      }
    }
    Overrides {
      Name: "cs:notify_text"
      ObjectReference {
        SelfId: 10726210978389988053
      }
    }
    Overrides {
      Name: "cs:trophy_notification"
      ObjectReference {
        SelfId: 8649801573269615484
      }
    }
    Overrides {
      Name: "cs:trophy_text"
      ObjectReference {
        SelfId: 4677442487658515326
      }
    }
  }
  Collidable_v2 {
    Value: "mc:ecollisionsetting:inheritfromparent"
  }
  Visible_v2 {
    Value: "mc:evisibilitysetting:inheritfromparent"
  }
  CameraCollidable {
    Value: "mc:ecollisionsetting:inheritfromparent"
  }
  Script {
    ScriptAsset {
      Id: 11966403431604522903
    }
  }
}
Objects {
  Id: 2365147788075538306
  Name: "Node_Information_Client"
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
      Name: "cs:YOOTIL"
      AssetReference {
        Id: 16622261663679835299
      }
    }
    Overrides {
      Name: "cs:container"
      ObjectReference {
        SelfId: 12322107661146682250
      }
    }
    Overrides {
      Name: "cs:title"
      ObjectReference {
        SelfId: 18233654196630558248
      }
    }
    Overrides {
      Name: "cs:info_text_1"
      ObjectReference {
        SelfId: 13707085705429800773
      }
    }
    Overrides {
      Name: "cs:info_text_2"
      ObjectReference {
        SelfId: 12994086293267801199
      }
    }
    Overrides {
      Name: "cs:view_code_button"
      ObjectReference {
        SelfId: 3748829169966813720
      }
    }
    Overrides {
      Name: "cs:close_button"
      ObjectReference {
        SelfId: 10395205942807004827
      }
    }
    Overrides {
      Name: "cs:API"
      AssetReference {
        Id: 11355776926042268297
      }
    }
    Overrides {
      Name: "cs:code_panel"
      ObjectReference {
        SelfId: 1240967016595903137
      }
    }
    Overrides {
      Name: "cs:code_border"
      ObjectReference {
        SelfId: 4514313148936373051
      }
    }
    Overrides {
      Name: "cs:code_background"
      ObjectReference {
        SelfId: 14996544896829060685
      }
    }
    Overrides {
      Name: "cs:code_close"
      ObjectReference {
        SelfId: 13247117291462406307
      }
    }
    Overrides {
      Name: "cs:code_title"
      ObjectReference {
        SelfId: 4520630516428714105
      }
    }
  }
  Collidable_v2 {
    Value: "mc:ecollisionsetting:inheritfromparent"
  }
  Visible_v2 {
    Value: "mc:evisibilitysetting:inheritfromparent"
  }
  CameraCollidable {
    Value: "mc:ecollisionsetting:inheritfromparent"
  }
  Script {
    ScriptAsset {
      Id: 17624300616347334191
    }
  }
}
Objects {
  Id: 8251904590631658214
  Name: "Game_Manager_Client"
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
      Name: "cs:base_ui"
      ObjectReference {
        SelfId: 5361995976725761005
      }
    }
    Overrides {
      Name: "cs:node_ui"
      ObjectReference {
        SelfId: 3627026760658224672
      }
    }
    Overrides {
      Name: "cs:top_ui"
      ObjectReference {
        SelfId: 9651766503307601252
      }
    }
    Overrides {
      Name: "cs:YOOTIL"
      AssetReference {
        Id: 16622261663679835299
      }
    }
  }
  Collidable_v2 {
    Value: "mc:ecollisionsetting:inheritfromparent"
  }
  Visible_v2 {
    Value: "mc:evisibilitysetting:inheritfromparent"
  }
  CameraCollidable {
    Value: "mc:ecollisionsetting:inheritfromparent"
  }
  Script {
    ScriptAsset {
      Id: 5597919196133201147
    }
  }
}
Objects {
  Id: 2366539210659061100
  Name: "Transition_Manager_Client"
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
      Name: "cs:container"
      ObjectReference {
        SelfId: 18256827771134331817
      }
    }
    Overrides {
      Name: "cs:transition"
      ObjectReference {
        SelfId: 18258593271636195432
      }
    }
    Overrides {
      Name: "cs:YOOTIL"
      AssetReference {
        Id: 16622261663679835299
      }
    }
    Overrides {
      Name: "cs:in_time"
      Float: 1
    }
    Overrides {
      Name: "cs:out_time"
      Float: 1
    }
    Overrides {
      Name: "cs:color"
      Color {
        A: 1
      }
    }
    Overrides {
      Name: "cs:square"
      ObjectReference {
        SelfId: 11724735906383418054
      }
    }
    Overrides {
      Name: "cs:circle"
      ObjectReference {
        SelfId: 14627965831153303706
      }
    }
    Overrides {
      Name: "cs:triangle"
      ObjectReference {
        SelfId: 6441629203322883925
      }
    }
    Overrides {
      Name: "cs:loading"
      ObjectReference {
        SelfId: 16860121657648772684
      }
    }
  }
  Collidable_v2 {
    Value: "mc:ecollisionsetting:inheritfromparent"
  }
  Visible_v2 {
    Value: "mc:evisibilitysetting:inheritfromparent"
  }
  CameraCollidable {
    Value: "mc:ecollisionsetting:inheritfromparent"
  }
  Script {
    ScriptAsset {
      Id: 6027153021280345616
    }
  }
}
Objects {
  Id: 8975716410678032075
  Name: "Main_Menu_Client"
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
      Name: "cs:YOOTIL"
      AssetReference {
        Id: 16622261663679835299
      }
    }
    Overrides {
      Name: "cs:play_button"
      ObjectReference {
        SelfId: 7420985129170304630
      }
    }
    Overrides {
      Name: "cs:menu_container"
      ObjectReference {
        SelfId: 11482603222431002241
      }
    }
    Overrides {
      Name: "cs:credits_button"
      ObjectReference {
        SelfId: 10350323938109316302
      }
    }
    Overrides {
      Name: "cs:credits_panel"
      ObjectReference {
        SelfId: 14455612488292174611
      }
    }
    Overrides {
      Name: "cs:trophies_button"
      ObjectReference {
        SelfId: 6166162411575875244
      }
    }
    Overrides {
      Name: "cs:trophies_panel"
      ObjectReference {
        SelfId: 2427144955837788352
      }
    }
    Overrides {
      Name: "cs:leaderboards_button"
      ObjectReference {
        SelfId: 10246503101097449340
      }
    }
    Overrides {
      Name: "cs:leaderboards_panel"
      ObjectReference {
        SelfId: 2822459773352246712
      }
    }
    Overrides {
      Name: "cs:click_sound"
      ObjectReference {
        SelfId: 7452552501637593875
      }
    }
    Overrides {
      Name: "cs:hover_sound"
      ObjectReference {
        SelfId: 8328458776128072025
      }
    }
    Overrides {
      Name: "cs:menu"
      ObjectReference {
        SelfId: 3094242208622476276
      }
    }
    Overrides {
      Name: "cs:bg_effect"
      ObjectReference {
        SelfId: 14198457608431680772
      }
    }
  }
  Collidable_v2 {
    Value: "mc:ecollisionsetting:inheritfromparent"
  }
  Visible_v2 {
    Value: "mc:evisibilitysetting:inheritfromparent"
  }
  CameraCollidable {
    Value: "mc:ecollisionsetting:inheritfromparent"
  }
  Script {
    ScriptAsset {
      Id: 5687259373558289114
    }
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
    Overrides {
      Name: "cs:main_menu"
      ObjectReference {
        SelfId: 2074062803672340080
      }
    }
  }
  Collidable_v2 {
    Value: "mc:ecollisionsetting:inheritfromparent"
  }
  Visible_v2 {
    Value: "mc:evisibilitysetting:inheritfromparent"
  }
  CameraCollidable {
    Value: "mc:ecollisionsetting:inheritfromparent"
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
    Overrides {
      Name: "cs:save_button"
      ObjectReference {
        SelfId: 2323963055041167086
      }
    }
    Overrides {
      Name: "cs:main_menu_button"
      ObjectReference {
        SelfId: 1788394385922609731
      }
    }
  }
  Collidable_v2 {
    Value: "mc:ecollisionsetting:inheritfromparent"
  }
  Visible_v2 {
    Value: "mc:evisibilitysetting:inheritfromparent"
  }
  CameraCollidable {
    Value: "mc:ecollisionsetting:inheritfromparent"
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
      }
    }
    Overrides {
      Name: "cs:loading"
      ObjectReference {
        SelfId: 16860121657648772684
      }
    }
    Overrides {
      Name: "cs:API"
      AssetReference {
        Id: 11355776926042268297
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
    Overrides {
      Name: "cs:puzzle_3"
      AssetReference {
        Id: 16365751596071063277
      }
    }
    Overrides {
      Name: "cs:puzzle_4"
      AssetReference {
        Id: 293936147606257495
      }
    }
    Overrides {
      Name: "cs:puzzle_5"
      AssetReference {
        Id: 7150822721345186990
      }
    }
    Overrides {
      Name: "cs:puzzle_6"
      AssetReference {
        Id: 14293804084765077926
      }
    }
    Overrides {
      Name: "cs:puzzle_7"
      AssetReference {
        Id: 2278261616103010719
      }
    }
    Overrides {
      Name: "cs:puzzle_8"
      AssetReference {
        Id: 14882294843583922401
      }
    }
    Overrides {
      Name: "cs:puzzle_9"
      AssetReference {
        Id: 3757752652709371920
      }
    }
    Overrides {
      Name: "cs:puzzle_10"
      AssetReference {
        Id: 5798020608501261929
      }
    }
    Overrides {
      Name: "cs:puzzle_11"
      AssetReference {
        Id: 2988422183788330915
      }
    }
  }
  Collidable_v2 {
    Value: "mc:ecollisionsetting:inheritfromparent"
  }
  Visible_v2 {
    Value: "mc:evisibilitysetting:inheritfromparent"
  }
  CameraCollidable {
    Value: "mc:ecollisionsetting:inheritfromparent"
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
    Overrides {
      Name: "cs:API"
      AssetReference {
        Id: 11355776926042268297
      }
    }
  }
  Collidable_v2 {
    Value: "mc:ecollisionsetting:inheritfromparent"
  }
  Visible_v2 {
    Value: "mc:evisibilitysetting:inheritfromparent"
  }
  CameraCollidable {
    Value: "mc:ecollisionsetting:inheritfromparent"
  }
  Script {
    ScriptAsset {
      Id: 12955436264733002318
    }
  }
}
