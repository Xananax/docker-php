function confirm () {
    read -r -p "${1:-Are you certain?}[y/N]"
    case $(echo $REPLY | tr '[A-Z]' '[a-z]') in
        y|yes) 
            echo "yes"
            ;;
        *)
            echo "no"
            ;;
    esac
}