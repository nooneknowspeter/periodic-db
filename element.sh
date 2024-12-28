#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

# global vars
QUERY_ELEMENT="something"

# empty arg
if [[ -z $1 ]]; then

  echo "Please provide an element as an argument."

# when arg is a number
elif [[ $1 =~ ^[0-9]+$ ]]; then

  # query database using argument
  QUERY_ELEMENT=$($PSQL "SELECT * FROM elements INNER JOIN properties USING (atomic_number) WHERE atomic_number = $1")

  # present information
  echo "$QUERY_ELEMENT" | while IFS='|' read ATOMIC_NUMBER ATOMIC_SYMBOL ELEMENT_NAME ELEMENT_TYPE ATOMIC_MASS MELTING_POINT BOILING_POINT TYPE_ID; do

    echo -e "\nThe element with atomic number $ATOMIC_NUMBER is $ELEMENT_NAME ($ATOMIC_SYMBOL). It's a $ELEMENT_TYPE, with a mass of $ATOMIC_MASS amu. $ELEMENT_NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
  done

# when arg is a char
elif [[ $1 = [[:alpha:]] ]]; then

  echo "single char"

# when arg is a string
elif [[ $1 ]]; then

  echo "string"
  
else

  echo -e "\nI could not find that element in the database."
  
fi
