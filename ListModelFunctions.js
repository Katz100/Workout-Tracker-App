let currentWorkoutIndex = 0;
let currentSet = 1
let setsCompleted = 0;

function nextSet() {
    currentSet++;
    setsCompleted++;
    if (currentSet > lm.get(currentWorkoutIndex).sets)
    {
        currentSet = 1;
        currentWorkoutIndex++;
    }
}

function previousSet() {
    currentSet--;
    if (currentSet === 0)
    {
        //end of exercise but not end of first exercise
        if (currentWorkoutIndex !== 0)
        {
            currentWorkoutIndex--;
            currentSet = lm.get(currentWorkoutIndex).sets
        } else if (currentWorkoutIndex === 0 && currentSet === 0){
            currentSet = 1;
        } else {
            currentSet = lm.get(currentWorkoutIndex).sets;
        }
    }
}

function previousWorkout() {
    if (currentWorkoutIndex === 0) {
        return "N/A"
    } else {
        return lm.get(currentWorkoutIndex-1).workout_name
    }
}
function nextWorkout() {
    if (currentWorkoutIndex === lm.count-1) {
        return "N/A"
    } else {
        return lm.get(currentWorkoutIndex+1).workout_name
    }
}

function isWorkoutFinished() {
    return currentWorkoutIndex >= lm.count
}

function resetWorkout() {
    currentWorkoutIndex = 1;
    currentSet = 1;
    setsCompleted = 0;
}

function getWorkouts(day) {
    if (!isEmpty()) {
        lm.clear()
    }
    let workouts = Database.getWorkouts(day);

    for (let i = 0; i < workouts.length; i++) {
        lm.append(workouts[i]);
    }
}

function updateListModel(index, newWorkout) {
    lm.set(index, newWorkout)
}

function estimateWorkout(day) {
    let sets = Database.countSets(day);
    let rest = Database.findAverage(day);
    return (sets * (rest/60)).toFixed(2);
}

function isEmpty() {
    return (lm.count == 0)
}


