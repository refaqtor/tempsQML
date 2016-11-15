import QtQuick 2.0

Item {
    Image {
        width: 80
        height: 80
        anchors { top: parent.top; topMargin: parent.height * 0.14; left: parent.left; leftMargin: parent.width * 0.08; }
        source: WeatherModel.currentWeather.weather_codition_icon_id === "" ?
                    "images/icons/IconTemplate@02d.png" :
                    "images/icons/" + WeatherModel.currentWeather.weather_codition_icon_id + ".svg"
    }
    Column {
        height: 100
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: parent.height * 0.3 - 30
        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: degree.paintedWidth/2
            spacing: 0
            Text {
                font.pixelSize: 48
                color: "white"
                text: WeatherModel.roundup(WeatherModel.kelvin2celsius(WeatherModel.currentWeather.temp))
            }
            Text {
                id: degree
                font.pixelSize: 48
                color: "white"
                text: "\u00B0"
            }

        }
        Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter
            color: "white"
            //opacity: 0.5
            width: 24
            height: 2
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 18
            color: "white"
            opacity: 0.5
            text: WeatherModel.currentWeather.weather_codition_description
        }
    }
    Item {
        id: details
        anchors.bottom: parent.bottom
        width: parent.width
        height: 160
        Row {
            id: row
            width: parent.width
            spacing: 0
            anchors.top: parent.top

            Text {
                width: parent.width/2
                font.pixelSize: 12
                color: "#999999"
                text: Qt.formatDate(WeatherModel.currentWeather.timestamp, "dddd, MMM d")
                horizontalAlignment: Text.AlignHCenter
            }

            Text {
                width: parent.width/2
                font.pixelSize: 12
                color: "#999999"
                text: WeatherModel.cityName.toLowerCase() + ", " + WeatherModel.countryID.toLowerCase()
                horizontalAlignment: Text.AlignHCenter
            }
        }
        ListView {
            model: WeatherDailyModel
            clip: true
            interactive: true
            orientation: ListView.Horizontal
            anchors.top: row.bottom
            anchors.bottom: parent.bottom
            anchors.margins: 10
            width: parent.width
            delegate: WeatherDelegate {}
        }
    }
}