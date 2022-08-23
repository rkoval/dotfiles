return {
  parse(
    'nrc',
    [[
import classNames from 'classnames';

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
