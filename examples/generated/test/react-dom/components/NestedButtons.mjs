import React from "react"
import styled from "styled-components"

import colors from "../foundation/colors"
import shadows from "../foundation/shadows"
import textStyles from "../foundation/textStyles"
import Button from "../interactivity/Button"

export default class NestedButtons extends React.Component {
  render() {



    return (
      <View>
        <ButtonButtonWrapper>
          <Button label={"Button 1"} />
        </ButtonButtonWrapper>
        <View1 />
        <ButtonButton2Wrapper>
          <Button label={"Button 2"} />
        </ButtonButton2Wrapper>
      </View>
    );
  }
};

let View = styled.div({
  alignItems: "flex-start",
  display: "flex",
  flex: "1 1 0%",
  flexDirection: "column",
  justifyContent: "flex-start",
  paddingTop: "24px",
  paddingRight: "24px",
  paddingBottom: "24px",
  paddingLeft: "24px"
})

let ButtonButtonWrapper = styled.div({
  alignItems: "flex-start",
  alignSelf: "stretch",
  display: "flex",
  flex: "1 1 auto",
  flexDirection: "row",
  justifyContent: "flex-start"
})

let View1 = styled.div({
  alignItems: "flex-start",
  alignSelf: "stretch",
  display: "flex",
  flexDirection: "column",
  justifyContent: "flex-start",
  height: "8px"
})

let ButtonButton2Wrapper = styled.div({
  alignItems: "flex-start",
  alignSelf: "stretch",
  display: "flex",
  flex: "1 1 auto",
  flexDirection: "row",
  justifyContent: "flex-start"
})