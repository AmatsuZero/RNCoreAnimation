import React, { PureComponent } from "react"
import {
    FlatList,
    View,
    TouchableWithoutFeedback
} from "react-native"
import PropTypes from "prop-types"

export default class Panel extends PureComponent {
    static propTypes = {
        onSelect: PropTypes.func,
        dataSource: PropTypes.arrayOf(PropTypes.string).isRequired
    }
    constructor(props) {
        super(props)
        this.state = {
            dataSource: props.dataSource.map(color => ({color}))
        }
    }
    render() {
        return <FlatList data={this.state.dataSource}
                         horizontal={true}
                         keyExtractor={ (item, index) => "ColorPallet: " + item + index}
                         renderItem={ item => <TouchableWithoutFeedback
                             onPress={() => this.props.onSelect && this.props.onSelect(item.index)}
                         ><View style={{
                             backgroundColor: item.item.color
                         }}/>
                         </TouchableWithoutFeedback>}
                         style={this.props.style}
        />
    }
}
