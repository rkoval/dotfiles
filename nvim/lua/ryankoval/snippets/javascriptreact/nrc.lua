return {
  parse(
    'nrc',
    [[import React from 'react';

export default class ${1:${TM_FILENAME/(.+)\..+|.*/$1/:name}} extends React.Component {
  render() {
    return <div className="${1:${TM_FILENAME/(.+)\..+|.*/$1/:name}}">TODO</div>;
  }
}]]
  ),
}
