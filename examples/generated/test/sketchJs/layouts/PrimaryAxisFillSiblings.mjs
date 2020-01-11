import React from "react"
import { Text, Image, View, StyleSheet, TextStyles } from "react-sketchapp"

import colors from "../foundation/colors"
import shadows from "../foundation/shadows"
import textStyles from "../foundation/textStyles"

export default class PrimaryAxisFillSiblings extends React.Component {
  render() {



    return (
      <View style={styles.container}>
        <View style={styles.horizontal}>
          <View style={styles.leftCard}>
            <View style={styles.image}>
              <Image
                style={styles.imageResizeModeCover}
                source={require("../assets/icon_128x128.png")}

              />
            </View>
            <Text style={styles.title}>
              {"Title"}
            </Text>
            <Text style={styles.subtitle}>
              {"Subtitle"}
            </Text>
          </View>
          <View style={styles.spacer} />
          <View style={styles.rightCard}>
            <View style={styles.image1}>
              <Image
                style={styles.imageResizeModeCover}
                source={require("../assets/icon_128x128.png")}

              />
            </View>
            <Text style={styles.title1}>
              {"Title"}
            </Text>
            <Text style={styles.subtitle1}>
              {"Subtitle"}
            </Text>
          </View>
        </View>
      </View>
    );
  }
};

let styles = StyleSheet.create({
  container: {
    alignItems: "flex-start",
    alignSelf: "stretch",
    backgroundColor: colors.teal50,
    flex: 0,
    flexDirection: "column",
    justifyContent: "flex-start",
    paddingTop: 10,
    paddingRight: 10,
    paddingBottom: 10,
    paddingLeft: 10
  },
  horizontal: {
    alignItems: "flex-start",
    alignSelf: "stretch",
    backgroundColor: colors.teal100,
    flex: 0,
    flexDirection: "row",
    justifyContent: "flex-start"
  },
  leftCard: {
    alignItems: "flex-start",
    flex: 1,
    flexDirection: "column",
    justifyContent: "flex-start"
  },
  spacer: {
    alignItems: "flex-start",
    backgroundColor: "#D8D8D8",
    flexDirection: "column",
    justifyContent: "flex-start",
    width: 8,
    height: 0
  },
  rightCard: {
    alignItems: "flex-start",
    flex: 1,
    flexDirection: "column",
    justifyContent: "flex-start"
  },
  image: {
    alignItems: "flex-start",
    alignSelf: "stretch",
    backgroundColor: colors.teal200,
    flexDirection: "column",
    justifyContent: "flex-start",
    height: 100
  },
  title: {
    ...TextStyles.get("body2"),
    alignItems: "flex-start",
    alignSelf: "stretch",
    flex: 0,
    flexDirection: "column",
    justifyContent: "flex-start"
  },
  subtitle: {
    ...TextStyles.get("body1"),
    alignItems: "flex-start",
    alignSelf: "stretch",
    flex: 0,
    flexDirection: "column",
    justifyContent: "flex-start"
  },
  image1: {
    alignItems: "flex-start",
    alignSelf: "stretch",
    backgroundColor: colors.teal200,
    flexDirection: "column",
    justifyContent: "flex-start",
    height: 100
  },
  title1: {
    ...TextStyles.get("body2"),
    alignItems: "flex-start",
    alignSelf: "stretch",
    flex: 0,
    flexDirection: "column",
    justifyContent: "flex-start"
  },
  subtitle1: {
    ...TextStyles.get("body1"),
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