import React from "react"
import { View, StyleSheet, TextStyles } from "react-sketchapp"

import colors from "../foundation/colors"
import shadows from "../foundation/shadows"
import textStyles from "../foundation/textStyles"
import FillWidthFitHeightCard from "./FillWidthFitHeightCard"

export default class PrimaryAxisFillNestedSiblings extends React.Component {
  render() {



    return (
      <View style={styles.container}>
        <View style={styles.horizontal}>
          <View style={styles.leftCard}>
            <FillWidthFitHeightCard />
          </View>
          <View style={styles.spacer} />
          <View style={styles.rightCard}>
            <FillWidthFitHeightCard />
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
  }
})