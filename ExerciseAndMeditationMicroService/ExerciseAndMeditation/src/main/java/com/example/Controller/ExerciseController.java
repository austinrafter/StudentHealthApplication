package com.example.Controller;

import com.example.Model.Exercise;
import com.example.Model.ExerciseChartItem;
import com.example.Model.WeightExerciseChartItem;
import com.example.Model.PassExercise;
import com.example.Model.Student;
import com.example.Model.UserExercising;
import com.example.Repository.ExerciseRepository;
import com.example.Repository.PassExerciseRepository;
import com.example.Repository.UserExercisingRepository;
import com.example.Repository.StudentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.Duration;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.*;

@RestController
@RequestMapping(path = "/exercises")
public class ExerciseController {

    @Autowired
    private ExerciseRepository exerciseRepository;

    @Autowired
    private UserExercisingRepository userExercisingRepository;

    @Autowired
    private StudentRepository studentRepository;

    @Autowired
    private PassExerciseRepository passExerciseRepository;

    @GetMapping("/getExercises")
    public List<Exercise> getExercises(){
        return exerciseRepository.findAll();
    }

    @GetMapping("/getUserExercises")
    public List<UserExercising> getUserExercises(){
        return userExercisingRepository.findAll();
    }

    @GetMapping("/getUserTimedExercises")
    public List<ExerciseChartItem> getUserTimedExercises(){
        List<ExerciseChartItem> exerciseChartItemArrayList = new ArrayList<ExerciseChartItem>();
        List<PassExercise> passExercises = passExerciseRepository.findAll();

        for(PassExercise passExercise: passExercises){
            String date = passExercise.getDateof();
            String[] dateParts = date.split("T");
            ExerciseChartItem exerciseChartItem = new ExerciseChartItem((double)passExercise.getTotaltime()/60 , dateParts[0]);
            if(exerciseChartItemArrayList.size() == 0){
                exerciseChartItemArrayList.add(exerciseChartItem);
            }else{
                for(ExerciseChartItem exerciseChartItem1 : exerciseChartItemArrayList){
                    if(exerciseChartItem.getDate() == exerciseChartItem1.getDate()){
                        exerciseChartItem.setMinutes(exerciseChartItem.getMinutes() + exerciseChartItem1.getMinutes());
                    }
                }
            }
        }

        return exerciseChartItemArrayList;
    }

    @GetMapping("/getTest")
    public String getTest(){
        return "Connected";
    }

    @PostMapping("/add")
    public Exercise addExercise(@RequestBody Exercise exercise){
        return exerciseRepository.save(exercise);
    }

    @PostMapping("/addStudent")
    public Student addStudent(@RequestBody Student student){
        return studentRepository.save(student);
    }

    @GetMapping("/getStudents")
    public List<Student> getStudents(){
        return studentRepository.findAll();
    }

    @PostMapping("/getStudentIfPresent")
    public List<Student> getStudentIfPresent(@RequestBody Student student){
        List<Student>  students =  studentRepository.findByUsername(student.getUser_name());
        if(students != null){
            return students;
        }
        return null;
    }

    @PostMapping("/updateStudentWeight")
    public List<Student> updateUserWeight(@RequestBody Student student){
        List<Student> checkIfStudentPresent =  studentRepository.findByUsername(student.getUser_name());
        if(checkIfStudentPresent != null){
            if(student.getWeight() != checkIfStudentPresent.get(0).getWeight()){
                checkIfStudentPresent.get(0).setWeight(student.getWeight());
            }
            return checkIfStudentPresent;
        }
        return null;
    }

    @PostMapping("/updateStudentSchool")
    public List<Student> updateUserSchool(@RequestBody Student student){
        List<Student> checkIfStudentPresent =  studentRepository.findByUsername(student.getUser_name());
        if(checkIfStudentPresent != null){
            if(student.getSchool() != checkIfStudentPresent.get(0).getSchool()){
                checkIfStudentPresent.get(0).setSchool(student.getSchool());
            }
            return checkIfStudentPresent;
        }
        return null;
    }


    @PostMapping("/addtouser")
    public PassExercise addUserExercise(@RequestBody PassExercise passExercise){
        //List<Exercise> exercises = exerciseRepository.findByExercisename(passExercise.getExercisename());
        //List<Student> students = studentRepository.findByUsername(passExercise.getUsername());
        //DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
        //LocalDateTime dateTimeEnded = LocalDateTime.parse(passExercise.getDateof(), formatter);
        //UserExercising userExercising = new UserExercising(exercises.get(0), students.get(0), dateTimeEnded, dateTimeEnded, passExercise.getTotaltime(), passExercise.getCaloriesburned());
        //userExercisingRepository.save(userExercising);
       return passExerciseRepository.save(passExercise);
    }

    @PutMapping("/update/{id}")
    public ResponseEntity updateExerciseForUser(@PathVariable Long id, @PathVariable LocalDateTime ended){
        boolean exist = userExercisingRepository.existsById(id);
        if(exist){
            UserExercising userExercising = userExercisingRepository.getById(id);
            Exercise exercise = userExercising.getExercise();
            Student student = userExercising.getStudent();
            double metabolicEquivalentScore = exercise.getMetabolic_equivalent_score();
            double studentWeight = student.getWeight();
            double weightInKilograms = studentWeight * 0.453592;
            double caloriesBurned = (metabolicEquivalentScore * 3.5 * weightInKilograms) / 200;
            userExercising.setCalories_burned(caloriesBurned);
            userExercising.setEnded_at(ended);
            userExercisingRepository.save(userExercising);
            Duration totalTime = Duration.between(userExercising.getStarted_at(),userExercising.getEnded_at());
            return new ResponseEntity<>("Calories burned for " + totalTime + " minutes exercised: " + caloriesBurned, HttpStatus.OK);
        }
        return new ResponseEntity<>("Did not begin an exercise", HttpStatus.BAD_REQUEST);
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity deleteExerciseForUser(@PathVariable Long id){
        boolean exist = userExercisingRepository.existsById(id);
        if(exist){
            userExercisingRepository.deleteById(id);
            return new ResponseEntity<>("Exercise deleted for user", HttpStatus.OK);
        }
        return new ResponseEntity<>("Exercise did not exist for user", HttpStatus.BAD_REQUEST);
    }


    @PostMapping("/getTotalExerciseTimeForDay")
    public int getTotalExerciseTimeForDay(@PathVariable String date){
        int totalTime = 0;
        List<PassExercise> passExerciseList = passExerciseRepository.findByDateofContaining(date);
        for(PassExercise passExercise: passExerciseList){
            totalTime += passExercise.getTotaltime();
        }
        return totalTime;
    }
    /*
    @PostMapping("/getTotalExerciseTimeBeforeStudying")
    public int getTotalExerciseTimeBeforeStudying(@PathVariable String date){
        int totalTime = 0;
        List<PassExercise> passExerciseList = passExerciseRepository.findByDateofContaining(date);
        List<PassExercise> passExerciseList1 = new List<PassExercise>();

        for(PassExercise passExercise: passExerciseList){

            if(passExercise.getDateof() <= date){
                passExerciseList1.add(passExercise);
            }
        }
        for(PassExercise passExercise: passExerciseList1){
            totalTime += passExercise.getTotaltime();
        }
        return totalTime;
    }

     */

    /*
    @PostMapping("/getFinalExerciseTime")
    public String getFinalExerciseTime(@PathVariable String date){
        List<PassExercise> passExerciseList = passExerciseRepository.findByDateofContaining(date);

        String[] dateAndTime = passExerciseList[passExerciseList.size() - 1].split("T", 0);

        return dateAndTime[1];

    }

     */

    @PostMapping("/getExercisesByType")
    public List<Exercise> getExercisesByType(@RequestBody Exercise exercise){
        return exerciseRepository.findByExercisetype(exercise.getExercisetype());
    }

    @PostMapping("/getExercisesByDate")
    public List<PassExercise> getExercisesByDate(@RequestBody PassExercise passExercise){
        System.out.println(passExercise.getDateof());
        return passExerciseRepository.findByDateofContaining(passExercise.getDateof());
    }

    @PostMapping("/getFavoriteExerciseForDate")
    public PassExercise getFavoriteExerciseForDate(@RequestBody PassExercise passExercise){
        //System.out.println(passExercise.getDateof());
        int max = 0;
        String exercisename1 = "";
        Map<String, Integer> maxExerciseName = new HashMap<String, Integer>();
        HashSet<String> exerciseNames = new HashSet<String>();

        List<PassExercise> passExerciseList = passExerciseRepository.findByDateofContaining(passExercise.getDateof());
        PassExercise passExercise1 = passExerciseList.get(0);

        for (PassExercise passExercise2: passExerciseList) {
            if(!exerciseNames.contains(passExercise2.getExercisename())){
                exerciseNames.add(passExercise2.getExercisename());
                maxExerciseName.put(passExercise2.getExercisename(),1);
            }else{
                maxExerciseName.put(passExercise2.getExercisename(), maxExerciseName.get(passExercise2.getExercisename()) + 1);
            }
        }

        for(String i : maxExerciseName.keySet()){
            if(maxExerciseName.get(i) > max){
                max = maxExerciseName.get(i);
                exercisename1 = i;
            }
        }

        for(PassExercise passExercise2: passExerciseList){
            if(exercisename1 == passExercise2.getExercisename()){
                passExercise1 = passExercise2;
                break;
            }
        }

        System.out.println(passExercise1.getPassexerciseid());
        System.out.println(passExercise1.getExercisename());
        return passExercise1;
    }



}
