import React from "react"
import styled from "styled-components"

import colors from "../foundation/colors"
import shadows from "../foundation/shadows"
import textStyles from "../foundation/textStyles"

export default class LocalAsset extends React.Component {
  render() {



    return <View> <Image src={require("../assets/icon_128x128.png")} /> </View>;
  }
};

let View = styled.div({
  alignItems: "flex-start",
  backgroundColor: colors.red400,
  display: "flex",
  flex: "0 0 auto",
  flexDirection: "column",
  justifyContent: "flex-start"
})

let Image = styled.img({
  alignItems: "flex-start",
  backgroundColor: "#D8D8D8",
  display: "flex",
  flexDirection: "column",
  justifyContent: "flex-start",
  overflow: "hidden",
  width: "100px",
  height: "100px",
  objectFit: "cover",
  position: "relative"
})