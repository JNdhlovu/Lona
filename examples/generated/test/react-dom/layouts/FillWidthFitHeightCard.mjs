import React from "react"
import styled from "styled-components"

import colors from "../foundation/colors"
import shadows from "../foundation/shadows"
import textStyles from "../foundation/textStyles"

export default class FillWidthFitHeightCard extends React.Component {
  render() {



    return (
      <View>
        <Image>
          <ImageResizeModeCover src={require("../assets/icon_128x128.png")} />
        </Image>
        <Text1>
          {"Title"}
        </Text1>
        <Text>
          {"Subtitle"}
        </Text>
      </View>
    );
  }
};

let ImageResizeModeCover = styled.img({
  width: "100%",
  height: "100%",
  objectFit: "cover",
  position: "absolute"
})

let View = styled.div({
  alignItems: "flex-start",
  display: "flex",
  flex: "1 1 0%",
  flexDirection: "column",
  justifyContent: "flex-start"
})

let Image = styled.div({
  alignItems: "flex-start",
  alignSelf: "stretch",
  backgroundColor: colors.blue200,
  display: "flex",
  flexDirection: "column",
  justifyContent: "flex-start",
  overflow: "hidden",
  height: "100px",
  position: "relative"
})

let Text1 = styled.span({
  textAlign: "left",
  ...textStyles.body2,
  alignItems: "flex-start",
  alignSelf: "stretch",
  display: "block",
  flex: "0 0 auto",
  flexDirection: "column",
  justifyContent: "flex-start"
})

let Text = styled.span({
  textAlign: "left",
  ...textStyles.body1,
  alignItems: "flex-start",
  alignSelf: "stretch",
  display: "block",
  flex: "0 0 auto",
  flexDirection: "column",
  justifyContent: "flex-start"
})