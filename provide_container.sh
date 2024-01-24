#!/bin/bash

show_help(){
    echo "Deploy basic ssh config to $HOME/.ssh/config."
    echo "usage: $0 [-d] [-i] [-r] [-t] [-u] [-x] [-a] [-y] [-b] [-h]"
    echo "  -d  dockerfile name"
    echo "  -i  image name"
    echo "  -r  remote host name"
    echo "  -t  image tag name"
    echo "  -u  remote host user name"
    echo "  -x  external drive 1 UUID"
    echo "  -a  external drive 1 format"
    echo "  -y  external drive 2 UUID"
    echo "  -b  external drive 2 format"
    echo "  -h  show help"
    exit 0
}

provide_container(){
    scp -v "${dockerfile}" "${user}@${remote}":"~/${dockerfile}"
    scp -v "smb.conf" "${user}@${remote}":"~/smb.conf"
    ssh -v -l "${user}" "${remote}" "sudo mkdir -pv /mnt/external_drive_1"
    ssh -v -l "${user}" "${remote}" "sudo chmod 777 /mnt/external_drive_1"
    ssh -v -l "${user}" "${remote}" "sudo mkdir -pv /mnt/external_drive_2"
    ssh -v -l "${user}" "${remote}" "sudo chmod 777 /mnt/external_drive_2"
    ssh -v -l "${user}" "${remote}" "echo "UUID=${external_drive_1}  /mnt/external_drive_1  ${external_drive_1_format}  defaults  0  2" | sudo tee -a /etc/fstab"
    ssh -v -l "${user}" "${remote}" "echo "UUID=${external_drive_2}  /mnt/external_drive_2  ${external_drive_2_format}  defaults  0  2" | sudo tee -a /etc/fstab"
    ssh -v -l "${user}" "${remote}" "docker kill \$(docker ps -q --filter ancestor=${image}:${tag})"
    ssh -v -l "${user}" "${remote}" "docker build -t ${image}:${tag} -f ./${dockerfile} ."
    ssh -v -l "${user}" "${remote}" "docker run -d --net=host -v /mnt/external_drive_1/tier1:/external_drive_1/tier1 -v /mnt/external_drive_1/tier2:/external_drive_1/tier2 -v /mnt/external_drive_1/tier3:/external_drive_1/tier3 -v /mnt/external_drive_2/tier2:/external_drive_2/tier2 -v /mnt/external_drive_2/tier3:/mnt/external_drive_2/tier3 --restart=unless-stopped ${image}:${tag}"
    exit 0
}

while getopts ":d:i:r:t:u:x:a:y:b:h" opt; do
  case $opt in
    d)
      dockerfile="$OPTARG"
      ;;
    i)
      image="$OPTARG"
      ;;
    r)
      remote="$OPTARG"
      ;;
    t)
      tag="$OPTARG"
      ;;
    u)
      user="$OPTARG"
      ;;
    x)
      external_drive_1="$OPTARG"
      ;;
    a)
      external_drive_1_format="$OPTARG"
      ;;
    y)
      external_drive_2="$OPTARG"
      ;;
    b)
      external_drive_2_format="$OPTARG"
      ;;
    h)
      show_help
      ;;
    \?)
      echo "unknown option: -$OPTARG" >&2
      show_help
      ;;
    :)
      echo "option requires an argument -$OPTARG." >&2
      show_help
      ;;
  esac
done

if [ "$#" -le 0 ]
then
  echo "script requires an option"
  show_help
fi

if [ -z "$dockerfile" ]
then
  echo "'-i' option is mandatory"
  show_help
fi


if [ -z "$image" ]
then
  echo "'-i' option is mandatory"
  show_help
fi

if [ -z "$remote" ]
then
  echo "'-r' option is mandatory"
  show_help
fi

if [ -z "$tag" ]
then
  echo "'-t' option is mandatory"
  show_help
fi

if [ -z "$user" ]
then
  echo "'-u' option is mandatory"
  show_help
fi

if [ -z "$external_drive_1" ]
then
  echo "'-u' option is mandatory"
  show_help
fi

if [ -z "$external_drive_2" ]
then
  echo "'-u' option is mandatory"
  show_help
fi

provide_container