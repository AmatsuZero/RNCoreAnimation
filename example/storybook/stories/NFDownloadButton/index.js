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
          width: 200,
          height: 200
        }
    }
    constructor(props) {
        super(props)
        this.state = {
            progress: 0,
            downloadState: "readyToDownload"
        }
    }
    render() {
        return <View style={this.styles.container}>
            <RNNFDownloadButton
                style={this.styles.button}
                downloadPercent={this.state.progress}
                onNewState={ target => {
                    const { state } = target.nativeEvent
                    if (state !== "readyToDownload") return
                    setTimeout(() => this.setState({
                        progress: 0.25
                    }), 2000)
                    setTimeout(() => this.setState({
                        progress: 0.6
                    }), 3000)
                    setTimeout(() => this.setState({
                        progress: 0.7
                    }), 4000)
                    setTimeout(() => this.setState({
                        progress: 0.95
                    }), 5000)
                    setTimeout(() => this.setState({
                        progress: 1
                    }), 6000)
                }}
            />
        </View>
    }
}