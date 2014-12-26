import QtQuick 2.2
import Ubuntu.Components 1.1
import QtPositioning 5.2
import QtSensors 5.2
import "content"

/*!
    \brief MainView with a Label and Button elements.
*/

Rectangle {
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
        value: geoposition.position===-1 ? 0 : geoposition.position.speed*60*60/1000*5/6
        //value: geoposition.position===-1 ? 0 : 100*5/6
    }
    //! [the dial in use]

    PositionSource {
        id: geoposition
        active: true
        updateInterval: 1000
    }

    Text {
        //text: geoposition.position.coordinate.altitude
        //text: geoposition.position.speedValid
        text: geoposition.position===-1 ? "-" : "Speed: " + Math.round( geoposition.position.speed ) + " m/s"
        //text: "Altitude: " + Math.round( geoposition.position.coordinate.altitude )
        //text: printablePositionMethod(geoposition.positioningMethod)
        font.family: "Helvetica"
        font.pointSize: 24
        color: "white"
    }
    QuitButton {
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.margins: 10
    }
}
