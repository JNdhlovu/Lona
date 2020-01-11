import React from "react"
import { View, StyleSheet, TextStyles } from "react-sketchapp"

import colors from "../foundation/colors"
import shadows from "../foundation/shadows"
import textStyles from "../foundation/textStyles"
import LocalAsset from "../images/LocalAsset"

export default class NestedBottomLeftLayout extends React.Component {
  render() {



    return (
      <View style={styles.view}>
        <View style={styles.view1}>
          <View style={styles.localAsset}>
            <LocalAsset />
          </View>
        </View>
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
  view1: {
    alignItems: "flex-end",
    backgroundColor: colors.red100,
    flexDirection: "row",
    justifyContent: "flex-start",
    width: 150,
    height: 150
  },
  localAsset: {
    alignItems: "flex-end",
    flex: 0,
    flexDirection: "column",
    justifyContent: "flex-start"
  }
})