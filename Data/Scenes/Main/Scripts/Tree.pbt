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
      Name: "cs:logic_puzzle_solutions"
      AssetReference {
        Id: 18057690391871807445
      }
    }
    Overrides {
      Name: "cs:math_puzzle_solutions"
      AssetReference {
        Id: 13151491769305644377
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
        SelfId: 841534158063459245
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
  ChildIds: 2366539210659061100
  ChildIds: 8251904590631658214
  ChildIds: 2365147788075538306
  ChildIds: 15163209075878739494
  ChildIds: 6068750308711967726
  ChildIds: 3385943649788916117
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
  Id: 3385943649788916117
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
      Name: "cs:menu_container"
      ObjectReference {
        SelfId: 3560492653544681397
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
      Name: "cs:bg_effect"
      ObjectReference {
        SelfId: 501076735454029765
      }
    }
    Overrides {
      Name: "cs:donate_button"
      ObjectReference {
        SelfId: 16320969655512262863
      }
    }
    Overrides {
      Name: "cs:tutorial_button"
      ObjectReference {
        SelfId: 240980488697631517
      }
    }
    Overrides {
      Name: "cs:donate_panel"
      ObjectReference {
        SelfId: 9384503764268272933
      }
    }
    Overrides {
      Name: "cs:my_games_panel"
      ObjectReference {
        SelfId: 1284222172028452821
      }
    }
    Overrides {
      Name: "cs:tutorial_panel"
      ObjectReference {
        SelfId: 6540510692168221284
      }
    }
    Overrides {
      Name: "cs:my_games_button"
      ObjectReference {
        SelfId: 14844984461882649663
      }
    }
    Overrides {
      Name: "cs:overrun_button"
      ObjectReference {
        SelfId: 16535097290882388630
      }
    }
    Overrides {
      Name: "cs:stonehenge_button"
      ObjectReference {
        SelfId: 6430374109958776374
      }
    }
    Overrides {
      Name: "cs:kooky_button"
      ObjectReference {
        SelfId: 8502755276440792793
      }
    }
    Overrides {
      Name: "cs:logic_button"
      ObjectReference {
        SelfId: 3922638577498897365
      }
    }
    Overrides {
      Name: "cs:logic_panel"
      ObjectReference {
        SelfId: 5780150087674612895
      }
    }
    Overrides {
      Name: "cs:math_button"
      ObjectReference {
        SelfId: 10162472854146894300
      }
    }
    Overrides {
      Name: "cs:math_panel"
      ObjectReference {
        SelfId: 17340309450090995398
      }
    }
    Overrides {
      Name: "cs:logic_play"
      ObjectReference {
        SelfId: 267037278439045037
      }
    }
    Overrides {
      Name: "cs:math_play"
      ObjectReference {
        SelfId: 11298080228596788631
      }
    }
    Overrides {
      Name: "cs:logic_list"
      ObjectReference {
        SelfId: 3248366722252660780
      }
    }
    Overrides {
      Name: "cs:math_list"
      ObjectReference {
        SelfId: 12120350464795933351
      }
    }
    Overrides {
      Name: "cs:logic_list_button"
      ObjectReference {
        SelfId: 15860248540404834328
      }
    }
    Overrides {
      Name: "cs:math_list_button"
      ObjectReference {
        SelfId: 15868026784496972201
      }
    }
    Overrides {
      Name: "cs:puzzle_list_entry"
      AssetReference {
        Id: 1647465547331546921
      }
    }
    Overrides {
      Name: "cs:logic_list_scroll"
      ObjectReference {
        SelfId: 6404696242457048192
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
    Overrides {
      Name: "cs:clear_button"
      ObjectReference {
        SelfId: 17291627843593195179
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
        SelfId: 841534158063459245
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
      Name: "cs:logic_puzzles_data"
      ObjectReference {
        SelfId: 12859574990951913593
      }
    }
    Overrides {
      Name: "cs:math_puzzles_data"
      ObjectReference {
        SelfId: 720670617962651731
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
