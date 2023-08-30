package app.controller;

import app.model.Course;
import app.model.Student;
import app.service.CourseServiceImpl;
import app.service.StudentServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Controller
@RequestMapping("/student")
@Component
@ComponentScan("app")
public class StudentController {

    @Autowired
    StudentServiceImpl studentService;

    @Autowired
    CourseServiceImpl courseService;

    @RequestMapping("/list")
    public ModelAndView studentsList(ModelMap modelMap){
        List<Student> students = studentService.getAllStudents();
        ModelAndView modelAndView = new ModelAndView("student-list");
        modelAndView.addObject("students", students);
        return modelAndView;
    }

    @GetMapping("/register")
    public ModelAndView studentRegister(ModelMap modelMap){
        int count = studentService.getStudentCount();
        if (count==0){
            modelMap.addAttribute("studentCount",1);
        }else{
            modelMap.addAttribute("studentCount",count+1);
        }
        List<Course> courses = courseService.getAllCourses();
        modelMap.addAttribute("courses",courses);
        Course coursecourse = courseService.getCourseByName("java");
        System.out.println("course = " + coursecourse);
        return new ModelAndView("student-register","student",new Student());
    }

    @PostMapping("/register")
    public String studentRegister(
            @ModelAttribute("student") Student student,
            ModelMap modelMap,
            @RequestParam("photo") MultipartFile photo,
            RedirectAttributes redirectAttributes
            ) throws IOException {

        System.out.println(student.getStudentName());
        String[] coursesNames = student.getStudentCourse().split(",");
        for (String c : coursesNames){
            System.out.println(c);
        }


        try{
            if (student.getStudentName().isEmpty()||student.getStudentDob().isEmpty()
                    ||student.getStudentGender().isEmpty()||student.getStudentPhone().isEmpty()
                    ||student.getStudentEducation().isEmpty()
            ){
                redirectAttributes.addFlashAttribute("message","emptyError");
                return "redirect:/student/register";
            }
        }catch (NullPointerException e){
            System.out.println(e.getMessage());
            redirectAttributes.addFlashAttribute("message","emptyError");
            return "redirect:/student/register";
        }

        String photoName = photo.getOriginalFilename();
        student.setStudentPhotoName(photoName);

        byte[] studentPhoto = photo.getBytes();
        student.setStudentPhoto(studentPhoto);

        List<Course> studentCourses = new ArrayList<>();
        System.out.println(coursesNames.length);


        for (String coursesName : coursesNames) {
            System.out.println(coursesName);
            Course course = courseService.getCourseByName(coursesName);
            System.out.println(course);
            studentCourses.add(course);
        }

        student.setStudentCourses(studentCourses);

        int result = studentService.registerStudent(student);

        if (result<1){
            modelMap.addAttribute("message","studentAddError");
            return "student-register";
        }


        return "redirect:/student/list";
    }
}
