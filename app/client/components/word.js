import React from 'react'

class Word extends React.Component {
  render() {
    return (
      <li>{this.props.value}</li>
    );
  }
};

Word.propTypes = {
  value: React.PropTypes.string.isRequired
}

export default Word
