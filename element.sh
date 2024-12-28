#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1 ]]; then
  echo "Please provide an element as an argument."
elif [[ $1 =~ ^[0-9]+$ ]]; then

  # query database using argument
  QUERY_ELEMENT=$($PSQL "SELECT * FROM elements INNER JOIN properties USING (atomic_number) WHERE atomic_number = $1")

  # present information
  echo "$QUERY_ELEMENT" | while IFS='|' read ATOMIC_NUMBER ATOMIC_SYMBOL ELEMENT_NAME ELEMENT_TYPE ATOMIC_MASS MELTING_POINT BOILING_POINT TYPE_ID; do

    echo -e "\nThe element with atomic number $ATOMIC_NUMBER is $ELEMENT_NAME ($ATOMIC_SYMBOL). It's a $ELEMENT_TYPE, with a mass of $ATOMIC_MASS amu. $ELEMENT_NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."

  done

fi

PRESENT_INFORMATION() {
  
}
