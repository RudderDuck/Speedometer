import QtQuick 2.2
import Ubuntu.Components 1.1
import QtPositioning 5.2
import QtSensors 5.2
import "content"

/*!
    \brief MainView with a Label and Button elements.
*/
MainView {
    // objectName for functional testing purposes (autopilot-qt5)
    objectName: "mainView"
    Label {
        text: i18n.tr('Version 0.2')
    }
    // Note! applicationName needs to match the "name" field of the click manifest
    applicationName: "com.ubuntu.developer.rudderduck.speedometer"
    property real factor : 3.6
    Page {
        Rectangle {
            id: rectangle
            anchors.centerIn: parent
            color: "#545454"
            width: 300; height: 300

            function printablePositionMethod(method) {
                var out = "source error";
                if (method === PositionSource.SatellitePositioningMethod) out = "Satellite";
                else if (method === PositionSource.NoPositioningMethod) out = "Not available";
                else if (method === PositionSource.NonSatellitePositioningMethod) out = "Non-satellite";
                else if (method === PositionSource.AllPositioningMethods) out = "All/multiple";
                return out;
            }

            //! [the dial in use]
            // Dial with a slider to adjust it
            Dial {
                id: dial
                anchors.centerIn: parent
                //value: slider.x * 100 / (container.width - 34)
                //value: 0
                //Math.round( geoposition.position.coordinate.altitude )
                value: geoposition.position.speedValid===false ? 0 : geoposition.position.speed*factor
                //value: geoposition.position===-1 ? 0 : 100*5/6
            }
            //! [the dial in use]

            PositionSource {
                id: geoposition
                active: true
                updateInterval: 500
            }

            Text {
                //text: geoposition.position.coordinate.altitude
                //text: geoposition.position.speedValid
                //text: geoposition.position.speedValid===false ? 0 : geoposition.position.speed*factor
                //text: "Altitude: " + Math.round( geoposition.position.coordinate.altitude )
                //text: printablePositionMethod(geoposition.positioningMethod)
                font.family: "Helvetica"
                font.pointSize: 24
                color: "white"
            }


        }

        QuitButton {
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.margins: 10
        }
        tools: ToolbarItems {
            ToolbarButton {
                action: Action {
                    text: "Metric"
                    onTriggered: factor = 3.6
                }
            }
            ToolbarButton {
                action: Action {
                    text: "Imperial"
                    onTriggered: factor = 2.23694
                }
            }
        }
    }
}
