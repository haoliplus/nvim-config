def run_script(script, stdin=None):
    """Returns (stdout, stderr), raises error on non-zero return code"""
    import subprocess
    # Note: by using a list here (['bash', ...]) you avoid quoting issues, as the 
    # arguments are passed in exactly this order (spaces, quotes, and newlines won't
    # cause problems):
    proc = subprocess.Popen(['bash', '-c', script],
        stdout=None, # Using subprocess.PIPE if you do not want see it from tty
        stderr=None,
        stdin=subprocess.PIPE)
    stdout, stderr = proc.communicate()
    if proc.returncode:
        raise ScriptException(proc.returncode, stdout, stderr, script)
    return stdout, stderr

class ScriptException(Exception):
    def __init__(self, returncode, stdout, stderr, script):
        self.returncode = returncode
        self.stdout = stdout
        self.stderr = stderr
        Exception().__init__('Error in script')

script_str = '''

set -x
SYNC_CACHE_DIR="/tmp/src"
SYNC_TARGET_DIR="/tmp/trg"

mkdir -p ${SYNC_CACHE_DIR}
mkdir -p ${SYNC_CACHE_DIR}/done

shopt -s nullglob
array=(${SYNC_CACHE_DIR}/*txt)
num_record_to_sync=${#array[@]}
echo "${num_record_to_sync} records are waiting to sync"

batch_size=4
for (( i = 0; i < ${#array[@]}; i+=${batch_size} )); do
  ids=""
  for (( j=0; j < ${batch_size}; j+=1 )); do
    fname=${array[i+j]}
    if [[ -n "${fname}" ]]; then
      echo $i, ${fname} && sleep 10 && echo "DONE $i" &
      # rsync -avPRW --ignore-missing-args \
      #   --inplace --ignore-existing \
      #   --files-from=${fname} / ${SYNC_TARGET_DIR}  &&
      # mv ${fname} ${fname}.done &
      ids="${ids} $!"
    fi
  done
  # Wait the sync pids
  echo "wait for ${ids}"
  wait ${ids}
  echo "DONE ${ids}"
done

echo "Sync done"
'''


stdout, stderr = run_script(script_str)

