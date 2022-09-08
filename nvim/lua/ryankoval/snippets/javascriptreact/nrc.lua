return {
  parse(
    'nrc',
    [[
import styles from './${1:${TM_FILENAME/(.+)\..+|.*/$1/:name}}.css';
import classNames from 'classnames';

export const links = () => [{rel: 'stylesheet', href: styles}];

interface Props {
  className?: string;
}

export default function ${1:${TM_FILENAME/(.+)\..+|.*/$1/:name}}(props: Props) {
  const {className} = props;

  return (
    <div className={classNames('${1:${TM_FILENAME/(.+)\..+|.*/$1/:name}}', className)}>
      TODO
    </div>
  );
}]]
  ),
}
