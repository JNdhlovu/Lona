import React from "react"
import { Text, View, StyleSheet, TextStyles } from "react-sketchapp"

import colors from "../foundation/colors"
import shadows from "../foundation/shadows"
import textStyles from "../foundation/textStyles"

export default class TextStylesTest extends React.Component {
  render() {



    return (
      <View style={styles.view}>
        <Text style={styles.text1}>
          {"Text goes here"}
        </Text>
        <Text style={styles.text2}>
          {"Text goes here"}
        </Text>
        <Text style={styles.text3}>
          {"Text goes here"}
        </Text>
        <View style={styles.view3}>
          <Text style={styles.text4}>
            {"Text goes here"}
          </Text>
        </View>
        <View style={styles.view1}>
          <Text style={styles.text5}>
            {"Text goes here"}
          </Text>
        </View>
        <View style={styles.view2}>
          <Text style={styles.text6}>
            {
              "Text goes here and wraps around when it reaches the end of the text field."
            }
          </Text>
        </View>
        <Text style={styles.text7}>
          {"Text goes here"}
        </Text>
        <Text style={styles.text8}>
          {"Text goes here"}
        </Text>
        <Text style={styles.text9}>
          {"Text goes here"}
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
  text1: {
    ...TextStyles.get("display3"),
    alignItems: "flex-start",
    flex: 0,
    flexDirection: "column",
    justifyContent: "flex-start"
  },
  text2: {
    ...TextStyles.get("display2"),
    alignItems: "flex-start",
    flex: 0,
    flexDirection: "column",
    justifyContent: "flex-start"
  },
  text3: {
    ...TextStyles.get("display1"),
    alignItems: "flex-start",
    flex: 0,
    flexDirection: "column",
    justifyContent: "flex-start"
  },
  view3: {
    alignItems: "flex-start",
    alignSelf: "stretch",
    backgroundColor: colors.green50,
    flex: 0,
    flexDirection: "column",
    justifyContent: "flex-start"
  },
  view1: {
    alignItems: "flex-start",
    alignSelf: "stretch",
    backgroundColor: colors.green100,
    flex: 0,
    flexDirection: "column",
    justifyContent: "flex-start"
  },
  view2: {
    alignItems: "flex-start",
    alignSelf: "stretch",
    backgroundColor: colors.green200,
    flex: 0,
    flexDirection: "column",
    justifyContent: "flex-start"
  },
  text7: {
    ...TextStyles.get("body2"),
    alignItems: "flex-start",
    flex: 0,
    flexDirection: "column",
    justifyContent: "flex-start"
  },
  text8: {
    ...TextStyles.get("body1"),
    alignItems: "flex-start",
    flex: 0,
    flexDirection: "column",
    justifyContent: "flex-start"
  },
  text9: {
    ...TextStyles.get("caption"),
    alignItems: "flex-start",
    flex: 0,
    flexDirection: "column",
    justifyContent: "flex-start"
  },
  text4: {
    ...TextStyles.get("headline"),
    alignItems: "flex-start",
    flex: 0,
    flexDirection: "column",
    justifyContent: "flex-start"
  },
  text5: {
    ...TextStyles.get("subheading2"),
    alignItems: "flex-start",
    flex: 0,
    flexDirection: "column",
    justifyContent: "flex-start"
  },
  text6: {
    ...TextStyles.get("subheading1"),
    alignItems: "flex-start",
    flex: 0,
    flexDirection: "column",
    justifyContent: "flex-start"
  }
})