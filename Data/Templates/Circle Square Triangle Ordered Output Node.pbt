Assets {
  Id: 8727627210173771119
  Name: "Circle Square Triangle Ordered Output Node"
  PlatformAssetType: 5
  TemplateAsset {
    ObjectBlock {
      RootId: 6254348041809456783
      Objects {
        Id: 6254348041809456783
        Name: "Circle Square Triangle Ordered Output Node"
        Transform {
          Scale {
            X: 1
            Y: 1
            Z: 1
          }
        }
        ParentId: 3627026760658224672
        ChildIds: 10513510733252188164
        ChildIds: 4399201721991925318
        ChildIds: 5380394750965652599
        ChildIds: 4451813809352686936
        ChildIds: 3853145885645221719
        ChildIds: 11461328781055174343
        ChildIds: 5334992306673215071
        UnregisteredParameters {
          Overrides {
            Name: "cs:can_move"
            Bool: true
          }
        }
        Collidable_v2 {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Visible_v2 {
          Value: "mc:evisibilitysetting:forceon"
        }
        CameraCollidable {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Control {
          Width: 280
          Height: 150
          UIX: 449.5
          UIY: -177.227966
          RenderTransformPivot {
            Anchor {
              Value: "mc:euianchor:middlecenter"
            }
          }
          Panel {
            Opacity: 1
          }
          AnchorLayout {
            SelfAnchor {
              Anchor {
                Value: "mc:euianchor:middlecenter"
              }
            }
            TargetAnchor {
              Anchor {
                Value: "mc:euianchor:middlecenter"
              }
            }
          }
        }
      }
      Objects {
        Id: 10513510733252188164
        Name: "Highlight Border"
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
        ParentId: 6254348041809456783
        Collidable_v2 {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Visible_v2 {
          Value: "mc:evisibilitysetting:forceoff"
        }
        CameraCollidable {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Control {
          Width: 5
          Height: 55
          UIY: -3
          RenderTransformPivot {
            Anchor {
              Value: "mc:euianchor:middlecenter"
            }
          }
          AddSizeToParentIfUsingParentSize: true
          UseParentWidth: true
          UseParentHeight: true
          Image {
            Brush {
              Id: 15322576452248986664
            }
            Color {
              R: 0.665387452
              G: 0.665387452
              B: 0.665387452
              A: 1
            }
            TeamSettings {
            }
          }
          AnchorLayout {
            SelfAnchor {
              Anchor {
                Value: "mc:euianchor:topcenter"
              }
            }
            TargetAnchor {
              Anchor {
                Value: "mc:euianchor:topcenter"
              }
            }
          }
        }
      }
      Objects {
        Id: 4399201721991925318
        Name: "Input Connections"
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
        ParentId: 6254348041809456783
        ChildIds: 1208237745901707908
        Collidable_v2 {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Visible_v2 {
          Value: "mc:evisibilitysetting:inheritfromparent"
        }
        CameraCollidable {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Control {
          Width: 35
          Height: 35
          UIX: -140
          RenderTransformPivot {
            Anchor {
              Value: "mc:euianchor:middlecenter"
            }
          }
          Panel {
            Opacity: 1
          }
          AnchorLayout {
            SelfAnchor {
              Anchor {
                Value: "mc:euianchor:middlecenter"
              }
            }
            TargetAnchor {
              Anchor {
                Value: "mc:euianchor:middlecenter"
              }
            }
          }
        }
      }
      Objects {
        Id: 1208237745901707908
        Name: "Connection Handle"
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
        ParentId: 4399201721991925318
        ChildIds: 3420279525440455649
        ChildIds: 5615375509137700826
        Collidable_v2 {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Visible_v2 {
          Value: "mc:evisibilitysetting:inheritfromparent"
        }
        CameraCollidable {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Control {
          UIY: 60
          RenderTransformPivot {
            Anchor {
              Value: "mc:euianchor:middlecenter"
            }
          }
          UseParentWidth: true
          UseParentHeight: true
          Button {
            FontColor {
              A: 1
            }
            FontSize: 20
            ButtonColor {
              R: 0.994000077
              G: 0.962444186
            }
            HoveredColor {
              R: 1
              G: 1
              B: 1
              A: 1
            }
            PressedColor {
              R: 1
              G: 1
              B: 1
              A: 1
            }
            DisabledColor {
              R: 1
              G: 1
              B: 1
              A: 1
            }
            Brush {
              Id: 10644292420748989311
            }
            IsButtonEnabled: true
            OnlyUseMainColor: true
            ClickMode {
              Value: "mc:ebuttonclickmode:default"
            }
            Font {
            }
            Justification {
              Value: "mc:etextjustify:center"
            }
            VerticalJustification {
              Value: "mc:everticaljustification:center"
            }
          }
          AnchorLayout {
            SelfAnchor {
              Anchor {
                Value: "mc:euianchor:middlecenter"
              }
            }
            TargetAnchor {
              Anchor {
                Value: "mc:euianchor:middlecenter"
              }
            }
          }
        }
      }
      Objects {
        Id: 3420279525440455649
        Name: "Line"
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
        ParentId: 1208237745901707908
        UnregisteredParameters {
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
        Control {
          Height: 8
          UIX: -5
          RenderTransformPivot {
            Anchor {
              Value: "mc:euianchor:middlecenter"
            }
          }
          Image {
            Brush {
            }
            Color {
              R: 0.215860531
              G: 0.215860531
              B: 0.215860531
              A: 1
            }
            TeamSettings {
            }
          }
          AnchorLayout {
            SelfAnchor {
              Anchor {
                Value: "mc:euianchor:middleleft"
              }
            }
            TargetAnchor {
              Anchor {
                Value: "mc:euianchor:middleright"
              }
            }
          }
        }
      }
      Objects {
        Id: 5615375509137700826
        Name: "Connector"
        Transform {
          Location {
            X: 499.050201
            Y: 71.2487183
            Z: 216.32103
          }
          Rotation {
            Yaw: 8.05334663
          }
          Scale {
            X: 1
            Y: 1
            Z: 1
          }
        }
        ParentId: 1208237745901707908
        Collidable_v2 {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Visible_v2 {
          Value: "mc:evisibilitysetting:inheritfromparent"
        }
        CameraCollidable {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Control {
          Width: 50
          Height: 50
          RenderTransformPivot {
            Anchor {
              Value: "mc:euianchor:middlecenter"
            }
          }
          UseParentWidth: true
          UseParentHeight: true
          Image {
            Brush {
              Id: 10644292420748989311
            }
            Color {
              R: 0.215860531
              G: 0.215860531
              B: 0.215860531
              A: 1
            }
            TeamSettings {
            }
          }
          AnchorLayout {
            SelfAnchor {
              Anchor {
                Value: "mc:euianchor:middleleft"
              }
            }
            TargetAnchor {
              Anchor {
                Value: "mc:euianchor:middleleft"
              }
            }
          }
        }
      }
      Objects {
        Id: 5380394750965652599
        Name: "Background"
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
        ParentId: 6254348041809456783
        Collidable_v2 {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Visible_v2 {
          Value: "mc:evisibilitysetting:inheritfromparent"
        }
        CameraCollidable {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Control {
          Height: 50
          RenderTransformPivot {
            Anchor {
              Value: "mc:euianchor:middlecenter"
            }
          }
          AddSizeToParentIfUsingParentSize: true
          UseParentWidth: true
          UseParentHeight: true
          Image {
            Brush {
              Id: 15322576452248986664
            }
            Color {
              R: 0.0497065745
              G: 0.0497065745
              B: 0.0497065745
              A: 1
            }
            TeamSettings {
            }
          }
          AnchorLayout {
            SelfAnchor {
              Anchor {
                Value: "mc:euianchor:topcenter"
              }
            }
            TargetAnchor {
              Anchor {
                Value: "mc:euianchor:topcenter"
              }
            }
          }
        }
      }
      Objects {
        Id: 4451813809352686936
        Name: "Header Background"
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
        ParentId: 6254348041809456783
        Collidable_v2 {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Visible_v2 {
          Value: "mc:evisibilitysetting:inheritfromparent"
        }
        CameraCollidable {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Control {
          Height: 180
          RenderTransformPivot {
            Anchor {
              Value: "mc:euianchor:middlecenter"
            }
          }
          UseParentWidth: true
          UseParentHeight: true
          Image {
            Brush {
              Id: 15322576452248986664
            }
            Color {
              R: 0.51875
              G: 0.0606394149
              B: 0.080439195
              A: 1
            }
            TeamSettings {
            }
          }
          AnchorLayout {
            SelfAnchor {
              Anchor {
                Value: "mc:euianchor:topleft"
              }
            }
            TargetAnchor {
              Anchor {
                Value: "mc:euianchor:topleft"
              }
            }
          }
        }
      }
      Objects {
        Id: 3853145885645221719
        Name: "Body Background"
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
        ParentId: 6254348041809456783
        ChildIds: 14141509375483252958
        ChildIds: 6170505936534788079
        ChildIds: 10375304625393950566
        ChildIds: 2363784078660808004
        Collidable_v2 {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Visible_v2 {
          Value: "mc:evisibilitysetting:inheritfromparent"
        }
        CameraCollidable {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Control {
          Height: -50
          UIY: 50
          RenderTransformPivot {
            Anchor {
              Value: "mc:euianchor:middlecenter"
            }
          }
          AddSizeToParentIfUsingParentSize: true
          UseParentWidth: true
          UseParentHeight: true
          Image {
            Brush {
              Id: 2010827857625261080
            }
            Color {
              R: 0.0497065745
              G: 0.0497065745
              B: 0.0497065745
              A: 1
            }
            TeamSettings {
            }
          }
          AnchorLayout {
            SelfAnchor {
              Anchor {
                Value: "mc:euianchor:topleft"
              }
            }
            TargetAnchor {
              Anchor {
                Value: "mc:euianchor:topleft"
              }
            }
          }
        }
      }
      Objects {
        Id: 14141509375483252958
        Name: "Image"
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
        ParentId: 3853145885645221719
        ChildIds: 8638310469667101039
        ChildIds: 13766995338542764269
        Collidable_v2 {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Visible_v2 {
          Value: "mc:evisibilitysetting:forceon"
        }
        CameraCollidable {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Control {
          Width: 50
          Height: 50
          UIX: -80
          UIY: 23.9146194
          RenderTransformPivot {
            Anchor {
              Value: "mc:euianchor:middlecenter"
            }
          }
          Image {
            Brush {
              Id: 282048513447773438
            }
            Color {
              R: 1
              G: 1
              B: 1
              A: 1
            }
            TeamSettings {
            }
          }
          AnchorLayout {
            SelfAnchor {
              Anchor {
                Value: "mc:euianchor:middlecenter"
              }
            }
            TargetAnchor {
              Anchor {
                Value: "mc:euianchor:middlecenter"
              }
            }
          }
        }
      }
      Objects {
        Id: 8638310469667101039
        Name: "Circle Bubble"
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
        ParentId: 14141509375483252958
        ChildIds: 11392930748415487619
        Collidable_v2 {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Visible_v2 {
          Value: "mc:evisibilitysetting:inheritfromparent"
        }
        CameraCollidable {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Control {
          Width: 50
          Height: 25
          UIY: 35
          RenderTransformPivot {
            Anchor {
              Value: "mc:euianchor:middlecenter"
            }
          }
          Image {
            Brush {
            }
            Color {
              R: 0.198069349
              G: 0.0231533684
              B: 0.0307134502
              A: 1
            }
            TeamSettings {
            }
          }
          AnchorLayout {
            SelfAnchor {
              Anchor {
                Value: "mc:euianchor:bottomcenter"
              }
            }
            TargetAnchor {
              Anchor {
                Value: "mc:euianchor:bottomcenter"
              }
            }
          }
        }
      }
      Objects {
        Id: 11392930748415487619
        Name: "Count"
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
        ParentId: 8638310469667101039
        Collidable_v2 {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Visible_v2 {
          Value: "mc:evisibilitysetting:inheritfromparent"
        }
        CameraCollidable {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Control {
          Width: 200
          Height: 60
          UIY: -5
          RenderTransformPivot {
            Anchor {
              Value: "mc:euianchor:middlecenter"
            }
          }
          UseParentWidth: true
          UseParentHeight: true
          Text {
            Label: "0"
            Color {
              R: 1
              G: 1
              B: 1
              A: 1
            }
            Size: 20
            Justification {
              Value: "mc:etextjustify:center"
            }
            Font {
              Id: 18375965876900075365
            }
          }
          AnchorLayout {
            SelfAnchor {
              Anchor {
                Value: "mc:euianchor:middlecenter"
              }
            }
            TargetAnchor {
              Anchor {
                Value: "mc:euianchor:middlecenter"
              }
            }
          }
        }
      }
      Objects {
        Id: 13766995338542764269
        Name: "Order Bubble"
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
        ParentId: 14141509375483252958
        ChildIds: 3397253927385661348
        Collidable_v2 {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Visible_v2 {
          Value: "mc:evisibilitysetting:inheritfromparent"
        }
        CameraCollidable {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Control {
          Width: 50
          Height: 25
          UIY: -35
          RenderTransformPivot {
            Anchor {
              Value: "mc:euianchor:middlecenter"
            }
          }
          Image {
            Brush {
            }
            Color {
              R: 0.51875
              G: 0.0606394149
              B: 0.080438979
            }
            TeamSettings {
            }
          }
          AnchorLayout {
            SelfAnchor {
              Anchor {
                Value: "mc:euianchor:topcenter"
              }
            }
            TargetAnchor {
              Anchor {
                Value: "mc:euianchor:topcenter"
              }
            }
          }
        }
      }
      Objects {
        Id: 3397253927385661348
        Name: "Order"
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
        ParentId: 13766995338542764269
        Collidable_v2 {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Visible_v2 {
          Value: "mc:evisibilitysetting:inheritfromparent"
        }
        CameraCollidable {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Control {
          Width: 200
          Height: 60
          UIY: -5
          RenderTransformPivot {
            Anchor {
              Value: "mc:euianchor:middlecenter"
            }
          }
          UseParentWidth: true
          UseParentHeight: true
          Text {
            Label: "1"
            Color {
              R: 1
              G: 1
              B: 1
              A: 1
            }
            Size: 20
            Justification {
              Value: "mc:etextjustify:center"
            }
            Font {
              Id: 18375965876900075365
            }
          }
          AnchorLayout {
            SelfAnchor {
              Anchor {
                Value: "mc:euianchor:middlecenter"
              }
            }
            TargetAnchor {
              Anchor {
                Value: "mc:euianchor:middlecenter"
              }
            }
          }
        }
      }
      Objects {
        Id: 6170505936534788079
        Name: "Error Warning"
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
        ParentId: 3853145885645221719
        ChildIds: 6534855803973460656
        Collidable_v2 {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Visible_v2 {
          Value: "mc:evisibilitysetting:forceoff"
        }
        CameraCollidable {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Control {
          Width: 30
          Height: 30
          UIX: -12
          UIY: 8
          RenderTransformPivot {
            Anchor {
              Value: "mc:euianchor:middlecenter"
            }
          }
          Image {
            Brush {
              Id: 11827541898079449513
            }
            Color {
              R: 1
              A: 1
            }
            TeamSettings {
            }
          }
          AnchorLayout {
            SelfAnchor {
              Anchor {
                Value: "mc:euianchor:topright"
              }
            }
            TargetAnchor {
              Anchor {
                Value: "mc:euianchor:topright"
              }
            }
          }
        }
      }
      Objects {
        Id: 6534855803973460656
        Name: "UI Text Box"
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
        ParentId: 6170505936534788079
        Collidable_v2 {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Visible_v2 {
          Value: "mc:evisibilitysetting:inheritfromparent"
        }
        CameraCollidable {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Control {
          Width: 200
          Height: 60
          UIY: 7
          RenderTransformPivot {
            Anchor {
              Value: "mc:euianchor:middlecenter"
            }
          }
          UseParentWidth: true
          UseParentHeight: true
          Text {
            Label: "E"
            Color {
              R: 0.987000048
              A: 1
            }
            Size: 10
            Justification {
              Value: "mc:etextjustify:center"
            }
            Font {
            }
          }
          AnchorLayout {
            SelfAnchor {
              Anchor {
                Value: "mc:euianchor:middlecenter"
              }
            }
            TargetAnchor {
              Anchor {
                Value: "mc:euianchor:middlecenter"
              }
            }
          }
        }
      }
      Objects {
        Id: 10375304625393950566
        Name: "Image"
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
        ParentId: 3853145885645221719
        ChildIds: 2420348543834493208
        ChildIds: 18012572042634185359
        Collidable_v2 {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Visible_v2 {
          Value: "mc:evisibilitysetting:forceon"
        }
        CameraCollidable {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Control {
          Width: 50
          Height: 50
          UIY: 23.9146194
          RenderTransformPivot {
            Anchor {
              Value: "mc:euianchor:middlecenter"
            }
          }
          Image {
            Brush {
              Id: 13239260661472566277
            }
            Color {
              R: 1
              G: 1
              B: 1
              A: 1
            }
            TeamSettings {
            }
          }
          AnchorLayout {
            SelfAnchor {
              Anchor {
                Value: "mc:euianchor:middlecenter"
              }
            }
            TargetAnchor {
              Anchor {
                Value: "mc:euianchor:middlecenter"
              }
            }
          }
        }
      }
      Objects {
        Id: 2420348543834493208
        Name: "Square Bubble"
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
        ParentId: 10375304625393950566
        ChildIds: 84987380950023141
        Collidable_v2 {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Visible_v2 {
          Value: "mc:evisibilitysetting:inheritfromparent"
        }
        CameraCollidable {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Control {
          Width: 50
          Height: 25
          UIY: 35
          RenderTransformPivot {
            Anchor {
              Value: "mc:euianchor:middlecenter"
            }
          }
          Image {
            Brush {
            }
            Color {
              R: 0.198069349
              G: 0.0231533684
              B: 0.0307134502
              A: 1
            }
            TeamSettings {
            }
          }
          AnchorLayout {
            SelfAnchor {
              Anchor {
                Value: "mc:euianchor:bottomcenter"
              }
            }
            TargetAnchor {
              Anchor {
                Value: "mc:euianchor:bottomcenter"
              }
            }
          }
        }
      }
      Objects {
        Id: 84987380950023141
        Name: "Count"
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
        ParentId: 2420348543834493208
        Collidable_v2 {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Visible_v2 {
          Value: "mc:evisibilitysetting:inheritfromparent"
        }
        CameraCollidable {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Control {
          Width: 200
          Height: 60
          UIY: -5
          RenderTransformPivot {
            Anchor {
              Value: "mc:euianchor:middlecenter"
            }
          }
          UseParentWidth: true
          UseParentHeight: true
          Text {
            Label: "0"
            Color {
              R: 1
              G: 1
              B: 1
              A: 1
            }
            Size: 20
            Justification {
              Value: "mc:etextjustify:center"
            }
            Font {
              Id: 18375965876900075365
            }
          }
          AnchorLayout {
            SelfAnchor {
              Anchor {
                Value: "mc:euianchor:middlecenter"
              }
            }
            TargetAnchor {
              Anchor {
                Value: "mc:euianchor:middlecenter"
              }
            }
          }
        }
      }
      Objects {
        Id: 18012572042634185359
        Name: "Order Bubble"
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
        ParentId: 10375304625393950566
        ChildIds: 12248284961697781390
        Collidable_v2 {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Visible_v2 {
          Value: "mc:evisibilitysetting:inheritfromparent"
        }
        CameraCollidable {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Control {
          Width: 50
          Height: 25
          UIY: -35
          RenderTransformPivot {
            Anchor {
              Value: "mc:euianchor:middlecenter"
            }
          }
          Image {
            Brush {
            }
            Color {
              R: 0.51875
              G: 0.0606394149
              B: 0.080438979
            }
            TeamSettings {
            }
          }
          AnchorLayout {
            SelfAnchor {
              Anchor {
                Value: "mc:euianchor:topcenter"
              }
            }
            TargetAnchor {
              Anchor {
                Value: "mc:euianchor:topcenter"
              }
            }
          }
        }
      }
      Objects {
        Id: 12248284961697781390
        Name: "Order"
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
        ParentId: 18012572042634185359
        Collidable_v2 {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Visible_v2 {
          Value: "mc:evisibilitysetting:inheritfromparent"
        }
        CameraCollidable {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Control {
          Width: 200
          Height: 60
          UIY: -5
          RenderTransformPivot {
            Anchor {
              Value: "mc:euianchor:middlecenter"
            }
          }
          UseParentWidth: true
          UseParentHeight: true
          Text {
            Label: "2"
            Color {
              R: 1
              G: 1
              B: 1
              A: 1
            }
            Size: 20
            Justification {
              Value: "mc:etextjustify:center"
            }
            Font {
              Id: 18375965876900075365
            }
          }
          AnchorLayout {
            SelfAnchor {
              Anchor {
                Value: "mc:euianchor:middlecenter"
              }
            }
            TargetAnchor {
              Anchor {
                Value: "mc:euianchor:middlecenter"
              }
            }
          }
        }
      }
      Objects {
        Id: 2363784078660808004
        Name: "Image"
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
        ParentId: 3853145885645221719
        ChildIds: 11139799163672172294
        ChildIds: 13775540331967765650
        Collidable_v2 {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Visible_v2 {
          Value: "mc:evisibilitysetting:forceon"
        }
        CameraCollidable {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Control {
          Width: 50
          Height: 50
          UIX: 80
          UIY: 23.9146194
          RenderTransformPivot {
            Anchor {
              Value: "mc:euianchor:middlecenter"
            }
          }
          Image {
            Brush {
              Id: 4900954416202036311
            }
            Color {
              R: 1
              G: 1
              B: 1
              A: 1
            }
            TeamSettings {
            }
          }
          AnchorLayout {
            SelfAnchor {
              Anchor {
                Value: "mc:euianchor:middlecenter"
              }
            }
            TargetAnchor {
              Anchor {
                Value: "mc:euianchor:middlecenter"
              }
            }
          }
        }
      }
      Objects {
        Id: 11139799163672172294
        Name: "Triangle Bubble"
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
        ParentId: 2363784078660808004
        ChildIds: 11253177808514984407
        Collidable_v2 {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Visible_v2 {
          Value: "mc:evisibilitysetting:inheritfromparent"
        }
        CameraCollidable {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Control {
          Width: 50
          Height: 25
          UIY: 35
          RenderTransformPivot {
            Anchor {
              Value: "mc:euianchor:middlecenter"
            }
          }
          Image {
            Brush {
            }
            Color {
              R: 0.198069349
              G: 0.0231533684
              B: 0.0307134502
              A: 1
            }
            TeamSettings {
            }
          }
          AnchorLayout {
            SelfAnchor {
              Anchor {
                Value: "mc:euianchor:bottomcenter"
              }
            }
            TargetAnchor {
              Anchor {
                Value: "mc:euianchor:bottomcenter"
              }
            }
          }
        }
      }
      Objects {
        Id: 11253177808514984407
        Name: "Count"
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
        ParentId: 11139799163672172294
        Collidable_v2 {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Visible_v2 {
          Value: "mc:evisibilitysetting:inheritfromparent"
        }
        CameraCollidable {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Control {
          Width: 200
          Height: 60
          UIY: -5
          RenderTransformPivot {
            Anchor {
              Value: "mc:euianchor:middlecenter"
            }
          }
          UseParentWidth: true
          UseParentHeight: true
          Text {
            Label: "0"
            Color {
              R: 1
              G: 1
              B: 1
              A: 1
            }
            Size: 20
            Justification {
              Value: "mc:etextjustify:center"
            }
            Font {
              Id: 18375965876900075365
            }
          }
          AnchorLayout {
            SelfAnchor {
              Anchor {
                Value: "mc:euianchor:middlecenter"
              }
            }
            TargetAnchor {
              Anchor {
                Value: "mc:euianchor:middlecenter"
              }
            }
          }
        }
      }
      Objects {
        Id: 13775540331967765650
        Name: "Order Bubble"
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
        ParentId: 2363784078660808004
        ChildIds: 11134792387377914877
        Collidable_v2 {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Visible_v2 {
          Value: "mc:evisibilitysetting:inheritfromparent"
        }
        CameraCollidable {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Control {
          Width: 50
          Height: 25
          UIY: -35
          RenderTransformPivot {
            Anchor {
              Value: "mc:euianchor:middlecenter"
            }
          }
          Image {
            Brush {
            }
            Color {
              R: 0.51875
              G: 0.0606394149
              B: 0.080438979
            }
            TeamSettings {
            }
          }
          AnchorLayout {
            SelfAnchor {
              Anchor {
                Value: "mc:euianchor:topcenter"
              }
            }
            TargetAnchor {
              Anchor {
                Value: "mc:euianchor:topcenter"
              }
            }
          }
        }
      }
      Objects {
        Id: 11134792387377914877
        Name: "Order"
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
        ParentId: 13775540331967765650
        Collidable_v2 {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Visible_v2 {
          Value: "mc:evisibilitysetting:inheritfromparent"
        }
        CameraCollidable {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Control {
          Width: 200
          Height: 60
          UIY: -5
          RenderTransformPivot {
            Anchor {
              Value: "mc:euianchor:middlecenter"
            }
          }
          UseParentWidth: true
          UseParentHeight: true
          Text {
            Label: "3"
            Color {
              R: 1
              G: 1
              B: 1
              A: 1
            }
            Size: 20
            Justification {
              Value: "mc:etextjustify:center"
            }
            Font {
              Id: 18375965876900075365
            }
          }
          AnchorLayout {
            SelfAnchor {
              Anchor {
                Value: "mc:euianchor:middlecenter"
              }
            }
            TargetAnchor {
              Anchor {
                Value: "mc:euianchor:middlecenter"
              }
            }
          }
        }
      }
      Objects {
        Id: 11461328781055174343
        Name: "Node Handle"
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
        ParentId: 6254348041809456783
        ChildIds: 14059943642346129
        ChildIds: 18301465313915427474
        ChildIds: 4008783219311578312
        Collidable_v2 {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Visible_v2 {
          Value: "mc:evisibilitysetting:inheritfromparent"
        }
        CameraCollidable {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Control {
          Width: 100
          Height: 55
          UIY: -2
          RenderTransformPivot {
            Anchor {
              Value: "mc:euianchor:middlecenter"
            }
          }
          UseParentWidth: true
          Button {
            FontColor {
              R: 0.723055363
              G: 0.67954272
              B: 0.67954272
              A: 1
            }
            FontSize: 32
            ButtonColor {
              R: 1
              G: 1
              B: 1
            }
            HoveredColor {
              R: 1
              G: 1
              B: 1
              A: 1
            }
            PressedColor {
              R: 1
              G: 1
              B: 1
              A: 1
            }
            DisabledColor {
              R: 1
              G: 1
              B: 1
              A: 1
            }
            Brush {
              Id: 841534158063459245
            }
            IsButtonEnabled: true
            OnlyUseMainColor: true
            ClickMode {
              Value: "mc:ebuttonclickmode:preciseclick"
            }
            Font {
              Id: 18375965876900075365
            }
            Justification {
              Value: "mc:etextjustify:center"
            }
            VerticalJustification {
              Value: "mc:everticaljustification:center"
            }
          }
          AnchorLayout {
            SelfAnchor {
              Anchor {
                Value: "mc:euianchor:topleft"
              }
            }
            TargetAnchor {
              Anchor {
                Value: "mc:euianchor:topleft"
              }
            }
          }
        }
      }
      Objects {
        Id: 14059943642346129
        Name: "Delete Node"
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
        ParentId: 11461328781055174343
        Collidable_v2 {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Visible_v2 {
          Value: "mc:evisibilitysetting:inheritfromparent"
        }
        CameraCollidable {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Control {
          Width: 25
          Height: 25
          UIX: -18
          UIY: 10
          RotationAngle: 45
          RenderTransformPivot {
            Anchor {
              Value: "mc:euianchor:middlecenter"
            }
          }
          Button {
            FontColor {
              A: 1
            }
            FontSize: 20
            ButtonColor {
              R: 0.723055363
              G: 0.67954272
              B: 0.67954272
              A: 1
            }
            HoveredColor {
              R: 1
              G: 0.939821124
              B: 0.939821124
              A: 1
            }
            PressedColor {
              R: 0.723055363
              G: 0.67954272
              B: 0.67954272
              A: 1
            }
            DisabledColor {
              R: 1
              G: 1
              B: 1
              A: 1
            }
            Brush {
              Id: 163119404164711089
            }
            IsButtonEnabled: true
            ClickMode {
              Value: "mc:ebuttonclickmode:default"
            }
            Font {
            }
            Justification {
              Value: "mc:etextjustify:center"
            }
            VerticalJustification {
              Value: "mc:everticaljustification:center"
            }
          }
          AnchorLayout {
            SelfAnchor {
              Anchor {
                Value: "mc:euianchor:middleright"
              }
            }
            TargetAnchor {
              Anchor {
                Value: "mc:euianchor:middleright"
              }
            }
          }
        }
      }
      Objects {
        Id: 18301465313915427474
        Name: "Node Name"
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
        ParentId: 11461328781055174343
        Collidable_v2 {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Visible_v2 {
          Value: "mc:evisibilitysetting:inheritfromparent"
        }
        CameraCollidable {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Control {
          Height: 37
          RenderTransformPivot {
            Anchor {
              Value: "mc:euianchor:middlecenter"
            }
          }
          UseParentWidth: true
          Text {
            Label: "Ordered Output"
            Color {
              R: 1
              G: 1
              B: 1
              A: 1
            }
            Size: 25
            Justification {
              Value: "mc:etextjustify:center"
            }
            Font {
              Id: 18375965876900075365
            }
          }
          AnchorLayout {
            SelfAnchor {
              Anchor {
                Value: "mc:euianchor:middlecenter"
              }
            }
            TargetAnchor {
              Anchor {
                Value: "mc:euianchor:middlecenter"
              }
            }
          }
        }
      }
      Objects {
        Id: 4008783219311578312
        Name: "Info"
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
        ParentId: 11461328781055174343
        Collidable_v2 {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Visible_v2 {
          Value: "mc:evisibilitysetting:inheritfromparent"
        }
        CameraCollidable {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Control {
          Width: 50
          Height: 50
          UIX: 7
          UIY: 1
          RenderTransformPivot {
            Anchor {
              Value: "mc:euianchor:middlecenter"
            }
          }
          Button {
            Label: "?"
            FontColor {
              R: 1
              G: 1
              B: 1
              A: 1
            }
            FontSize: 28
            ButtonColor {
              R: 0.723055363
              G: 0.67954272
              B: 0.67954272
            }
            HoveredColor {
              R: 1
              G: 0.939821124
              B: 0.939821124
              A: 1
            }
            PressedColor {
              R: 0.723055363
              G: 0.67954272
              B: 0.67954272
              A: 1
            }
            DisabledColor {
              R: 1
              G: 1
              B: 1
              A: 1
            }
            Brush {
              Id: 163119404164711089
            }
            IsButtonEnabled: true
            OnlyUseMainColor: true
            ClickMode {
              Value: "mc:ebuttonclickmode:default"
            }
            Font {
              Id: 18375965876900075365
            }
            Justification {
              Value: "mc:etextjustify:center"
            }
            VerticalJustification {
              Value: "mc:everticaljustification:center"
            }
          }
          AnchorLayout {
            SelfAnchor {
              Anchor {
                Value: "mc:euianchor:middleleft"
              }
            }
            TargetAnchor {
              Anchor {
                Value: "mc:euianchor:middleleft"
              }
            }
          }
        }
      }
      Objects {
        Id: 5334992306673215071
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
        ParentId: 6254348041809456783
        ChildIds: 11949948618469235478
        ChildIds: 6147378151360864337
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
        Id: 11949948618469235478
        Name: "Node_Information_Data"
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
        ParentId: 5334992306673215071
        UnregisteredParameters {
          Overrides {
            Name: "cs:info_height"
            Float: 395
          }
          Overrides {
            Name: "cs:button_offset"
            Float: 0
          }
          Overrides {
            Name: "cs:title"
            String: "Ordered Output"
          }
          Overrides {
            Name: "cs:info_1_text"
            String: "This node requires data to be received in a specific order and meet the conditions."
          }
          Overrides {
            Name: "cs:info_2_text"
            String: "Use Halt Nodes to order the data.  When connecting a Halt Node, it will receive an order based on how many Halt Nodes are currently connected to this node."
          }
          Overrides {
            Name: "cs:info_2_offset"
            Float: 200
          }
          Overrides {
            Name: "cs:show_code"
            Bool: false
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
            Id: 14631171582364972515
          }
        }
      }
      Objects {
        Id: 6147378151360864337
        Name: "Circle_Square_Triangle_Ordered_Output_Node"
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
        ParentId: 5334992306673215071
        UnregisteredParameters {
          Overrides {
            Name: "cs:API"
            AssetReference {
              Id: 11355776926042268297
            }
          }
          Overrides {
            Name: "cs:circle_count"
            ObjectReference {
              SubObjectId: 11392930748415487619
            }
          }
          Overrides {
            Name: "cs:square_count"
            ObjectReference {
              SubObjectId: 84987380950023141
            }
          }
          Overrides {
            Name: "cs:triangle_count"
            ObjectReference {
              SubObjectId: 11253177808514984407
            }
          }
          Overrides {
            Name: "cs:condition_circle"
            String: "circle"
          }
          Overrides {
            Name: "cs:condition_square"
            String: "square"
          }
          Overrides {
            Name: "cs:condition_triangle"
            String: "triangle"
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
            Id: 6467838778125374072
          }
        }
      }
    }
    Assets {
      Id: 15322576452248986664
      Name: "BG Flat 004"
      PlatformAssetType: 9
      PrimaryAsset {
        AssetType: "PlatformBrushAssetRef"
        AssetId: "BackgroundNoOutline_22"
      }
    }
    Assets {
      Id: 10644292420748989311
      Name: "BG Flat 006"
      PlatformAssetType: 9
      PrimaryAsset {
        AssetType: "PlatformBrushAssetRef"
        AssetId: "BackgroundNoOutline_015"
      }
    }
    Assets {
      Id: 2010827857625261080
      Name: "BG Flat 001"
      PlatformAssetType: 9
      PrimaryAsset {
        AssetType: "PlatformBrushAssetRef"
        AssetId: "BackgroundNoOutline_020"
      }
    }
    Assets {
      Id: 282048513447773438
      Name: "UI Basic Shape Circle"
      PlatformAssetType: 9
      PrimaryAsset {
        AssetType: "PlatformBrushAssetRef"
        AssetId: "UI_Basic_Shape_Circle"
      }
    }
    Assets {
      Id: 18375965876900075365
      Name: "Teko"
      PlatformAssetType: 28
      PrimaryAsset {
        AssetType: "FontAssetRef"
        AssetId: "TekoRegular_ref"
      }
    }
    Assets {
      Id: 11827541898079449513
      Name: "Alert Triangle"
      PlatformAssetType: 9
      PrimaryAsset {
        AssetType: "PlatformBrushAssetRef"
        AssetId: "UI_Scifi_Icon_029"
      }
    }
    Assets {
      Id: 13239260661472566277
      Name: "UI Basic Shape Square"
      PlatformAssetType: 9
      PrimaryAsset {
        AssetType: "PlatformBrushAssetRef"
        AssetId: "UI_Basic_Shape_Square"
      }
    }
    Assets {
      Id: 4900954416202036311
      Name: "Center Tri 001"
      PlatformAssetType: 9
      PrimaryAsset {
        AssetType: "PlatformBrushAssetRef"
        AssetId: "CenterTri_001"
      }
    }
    Assets {
      Id: 163119404164711089
      Name: "Crosshair 021"
      PlatformAssetType: 9
      PrimaryAsset {
        AssetType: "PlatformBrushAssetRef"
        AssetId: "Crosshair_021"
      }
    }
    PrimaryAssetId {
      AssetType: "None"
      AssetId: "None"
    }
  }
  SerializationVersion: 91
  VirtualFolderPath: "Nodes"
  VirtualFolderPath: "Output Nodes"
}
