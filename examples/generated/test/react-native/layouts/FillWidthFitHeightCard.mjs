import React from "react"
import { Text, Image, View, StyleSheet } from "react-native"

import colors from "../foundation/colors"
import shadows from "../foundation/shadows"
import textStyles from "../foundation/textStyles"

export default class FillWidthFitHeightCard extends React.Component {
  render() {



    return (
      <View style={styles.view}>
        <View style={styles.image}>
          <Image
            style={styles.imageResizeModeCover}
            source={require("../assets/icon_128x128.png")}

          />
        </View>
        <Text style={styles.text1}>
          {"Title"}
        </Text>
        <Text style={styles.text}>
          {"Subtitle"}
        </Text>
      </View>
    );
  }
};

let styles = StyleSheet.create({
  view: {
    alignItems: "flex-start",
    alignSelf: "stretch",
    flex: 0,
    flexDirection: "column",
    justifyContent: "flex-start"
  },
  image: {
    alignItems: "flex-start",
    alignSelf: "stretch",
    backgroundColor: colors.blue200,
    flexDirection: "column",
    justifyContent: "flex-start",
    height: 100
  },
  text1: {
    ...textStyles.body2,
    alignItems: "flex-start",
    alignSelf: "stretch",
    flex: 0,
    flexDirection: "column",
    justifyContent: "flex-start"
  },
  text: {
    ...textStyles.body1,
    alignItems: "flex-start",
    alignSelf: "stretch",
    flex: 0,
    flexDirection: "column",
    justifyContent: "flex-start"
  },
  imageResizeModeCover: {
    width: "100%",
    height: "100%",
    resizeMode: "cover",
    position: "absolute"
  }
})