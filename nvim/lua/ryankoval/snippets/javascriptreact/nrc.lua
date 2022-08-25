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
    <div className={classNames(className, '${1:${TM_FILENAME/(.+)\..+|.*/$1/:name}}')}>
      TODO
    </div>
  );
}]]
  ),
}
