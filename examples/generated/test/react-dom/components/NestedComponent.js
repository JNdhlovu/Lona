import React from "react"
import styled from "styled-components"

import colors from "../foundation/colors"
import shadows from "../foundation/shadows"
import textStyles from "../foundation/textStyles"
import FitContentParentSecondaryChildren from
  "../layouts/FitContentParentSecondaryChildren"
import LocalAsset from "../images/LocalAsset"

export default class NestedComponent extends React.Component {
  render() {



    return (
      <View>
        <Text>
          {"Example nested component"}
        </Text>
        <FitContentParentSecondaryChildrenFitContentParentSecondaryChildrenWrapper>
          <FitContentParentSecondaryChildren />
        </FitContentParentSecondaryChildrenFitContentParentSecondaryChildrenWrapper>
        <Text1>
          {"Text below"}
        </Text1>
        <LocalAssetLocalAssetWrapper>
          <LocalAsset />
        </LocalAssetLocalAssetWrapper>
        <Text2>
          {"Very bottom"}
        </Text2>
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
  paddingTop: "10px",
  paddingRight: "10px",
  paddingBottom: "10px",
  paddingLeft: "10px"
})

let Text = styled.span({
  textAlign: "left",
  ...textStyles.subheading2,
  alignItems: "flex-start",
  display: "block",
  flex: "0 0 auto",
  flexDirection: "column",
  justifyContent: "flex-start",
  marginBottom: "8px"
})

let FitContentParentSecondaryChildrenFitContentParentSecondaryChildrenWrapper = styled
.div({
  alignItems: "flex-start",
  alignSelf: "stretch",
  display: "flex",
  flex: "1 1 auto",
  flexDirection: "row",
  justifyContent: "flex-start"
})

let Text1 = styled.span({
  textAlign: "left",
  ...textStyles.body1,
  alignItems: "flex-start",
  display: "block",
  flex: "0 0 auto",
  flexDirection: "column",
  justifyContent: "flex-start",
  marginTop: "12px"
})

let LocalAssetLocalAssetWrapper = styled.div({
  alignItems: "flex-start",
  alignSelf: "stretch",
  display: "flex",
  flex: "1 1 auto",
  flexDirection: "row",
  justifyContent: "flex-start"
})

let Text2 = styled.span({
  textAlign: "left",
  ...textStyles.body1,
  alignItems: "flex-start",
  display: "block",
  flex: "0 0 auto",
  flexDirection: "column",
  justifyContent: "flex-start"
})