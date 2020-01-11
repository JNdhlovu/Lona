import React from "react"
import styled from "styled-components"

import colors from "../foundation/colors"
import shadows from "../foundation/shadows"
import textStyles from "../foundation/textStyles"
import Optionals from "../logic/Optionals"

export default class NestedOptionals extends React.Component {
  render() {



    return (
      <View>
        <OptionalsOptionalsWrapper>
          <Optionals boolParam={null} stringParam={"Text"} />
        </OptionalsOptionalsWrapper>
      </View>
    );
  }
};

let View = styled.div({
  alignItems: "flex-start",
  display: "flex",
  flex: "1 1 0%",
  flexDirection: "column",
  justifyContent: "flex-start"
})

let OptionalsOptionalsWrapper = styled.div({
  alignItems: "flex-start",
  alignSelf: "stretch",
  display: "flex",
  flex: "1 1 auto",
  flexDirection: "row",
  justifyContent: "flex-start"
})