import React, { Component } from "react"
import {
    View
} from "react-native"

import { RNNFDownloadButton } from "rn-coreanimation"

export default class RNNFDownoladButtonDemo extends Component {
    styles = {
        container: {
            flex: 1,
            alignItems:'center',
            justifyContent:'center',
            alignSelf: 'stretch'
        },
        button: {
          width: 100,
          height: 100
        }
    }
    constructor(props) {
        super(props)
        this.state = {
            progress: 0,
            downloadState: "toDownload"
        }
    }
    componentDidMount() {
        // const timer = setInterval(() => {
        //     if (this.state.progress <= 1)
        //         this.setState({
        //             progress: this.state.progress += 0.1
        //         })
        //     else
        //         clearInterval(timer)
        // }, 1000)
    }
    render() {
        return <View style={this.styles.container}>
            <RNNFDownloadButton
                style={this.styles.button}
                downloadPercent={this.state.progress}
            />
        </View>
    }
}