#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

# global vars
QUERY_ELEMENT="QUERY_ELEMENT"
ATOMIC_NUMBER="ATOMIC_NUMBER"
ATOMIC_SYMBOL="ATOMIC_SYMBOL"
ELEMENT_NAME="ELEMENT_NAME"
ELEMENT_TYPE="ELEMENT_TYPE"
ATOMIC_MASS="ATOMIC_MASS"
MELTING_POINT="MELTING_POINT"
BOILING_POINT="BOILING_POINT"
TYPE_ID="TYPE_ID"

NOT_FOUND() {

  echo "I could not find that element in the database."
}

QUERY() {

  echo "$QUERY_ELEMENT" | while IFS='|' read TYPE_ID ATOMIC_NUMBER ATOMIC_SYMBOL ELEMENT_NAME ATOMIC_MASS MELTING_POINT BOILING_POINT ELEMENT_TYPE; do

    # echo $QUERY_ELEMENT

    echo "The element with atomic number $ATOMIC_NUMBER is $ELEMENT_NAME ($ATOMIC_SYMBOL). It's a $ELEMENT_TYPE, with a mass of $ATOMIC_MASS amu. $ELEMENT_NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
  done

}

# empty arg
if [[ -z $1 ]]; then

  echo "Please provide an element as an argument."

# when arg is a number
elif [[ $1 =~ ^[0-9]+$ ]]; then

  # query database using argument
  QUERY_ELEMENT=$($PSQL "SELECT * FROM elements INNER JOIN properties USING (atomic_number) INNER JOIN types USING (type_id) WHERE atomic_number = $1")

  if [[ -z $QUERY_ELEMENT ]]; then

    NOT_FOUND

  else

    QUERY

  fi

# when arg is a string or char
elif [[ ! $1 =~ ^[0-9]+$ ]]; then

  # query database using argument
  QUERY_ELEMENT=$($PSQL "SELECT * FROM elements INNER JOIN properties USING (atomic_number) INNER JOIN types USING (type_id) WHERE name LIKE '$1%' LIMIT 1")

  if [[ -z $QUERY_ELEMENT ]]; then

    NOT_FOUND

  else

    QUERY

  fi

else

  NOT_FOUND

fi
