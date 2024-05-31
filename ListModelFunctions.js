let currentWorkoutIndex = 0;
let currentSet = 1

function nextSet() {
    currentSet++;
    if (currentSet > lm.get(currentWorkoutIndex).sets)
    {
        currentSet = 1;
        currentWorkoutIndex++
    }
}

function isWorkoutFinished() {
    return currentWorkoutIndex >= lm.count
}

function resetWorkout() {
    currentWorkoutIndex = 1;
    currentSet = 1;
}

function getWorkouts(day) {
    lm.clear()
    let workouts = Database.getWorkouts(day);

    for (let i = 0; i < workouts.length; i++) {
        lm.append(workouts[i]);
    }
}

function estimateWorkout(day) {
    let sets = Database.countSets(day);
    let rest = Database.findAverage(day);
    return (sets * (rest/60)).toFixed(2);
}

function isEmpty() {
    return (lm.count == 0)
}
