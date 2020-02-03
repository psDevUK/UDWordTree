import React from 'react';
import ReactDOM from "react-dom";
import Chart from "react-google-charts";

class UDWordTree extends React.Component {
  render() {
    const options = {
      wordtree: {
        format: "implicit",
        word: this.props.word
      }
    }
    return (
      <div className="WordTree">
        <Chart
          chartType="WordTree"
          width={this.props.width}
          height={this.props.height}
          data={this.props.data}
          options={options}
        />
      </div>
    )

  }
}

export default UDWordTree
