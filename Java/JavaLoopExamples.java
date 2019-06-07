
class JavaExample {

int counter = 1 ;  // Control variable initialized

// Condition for loop continuation
while (counter <= 10) {
   System.out.println(counter);
   counter++;     // Increment the control variable
}

// Never-ending loop or infinite loop
while (true) {   // Condition is always true
   // ... Some statements
}

 counter = 1;   // Control variable initialized

// Condition always evaluates to true
while (counter <= 10) {
   System.out.println(counter);
   counter--;      // Decrements the control variable
}

// The loop body will never execute
while (false) {    // Condition is always false
   System.out.println("This will never print");
}

// For(<initialization>;<condition>;<increment>
for(int counter = 1; counter <= 10; counter++){
   System.out.println(counter);
}

int counter;
for( counter = 1; counter <= 10; counter++){
   //... Statements
}

int counter = 1;
for(; counter <= 10; counter++){
   //... Statements
}

int counter = 1;
for(; counter <= 10;){
   //... Statements
   counter++;
}

// Infinite loop
for(;true;);

// Infinite loop
for(;;);

int counter = 1;   // Control variable initialized

do{
   System.out.println(counter);
   counter--;   // Decrements the control variable
}while(counter <= 10);   // Condition statement

while(counter++ <= 10);

while(counter <= 10)
   counter++;

do System.out.print("");
while(counter++ <= 10);

do counter++; while(counter <= 10);

do {
   counter++;
}while(counter <= 10);
}