import React from "react"
import styled from "styled-components"

import colors from "../foundation/colors"
import shadows from "../foundation/shadows"
import textStyles from "../foundation/textStyles"

export default class If extends React.Component {
  render() {


    let View$backgroundColor
    View$backgroundColor = "transparent"

    if (this.props.enabled) {

      View$backgroundColor = colors.red500
    }
    return <View style={{ backgroundColor: View$backgroundColor }} />;
  }
};

let View = styled.div({
  alignItems: "flex-start",
  display: "flex",
  flex: "1 1 0%",
  flexDirection: "column",
  justifyContent: "flex-start"
})