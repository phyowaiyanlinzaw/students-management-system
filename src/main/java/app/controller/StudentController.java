package app.controller;

import app.model.Student;
import app.service.StudentServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/student")
@Component
@ComponentScan("app")
public class StudentController {

    @Autowired
    StudentServiceImpl studentService;

    @GetMapping("/list")
    public String studentsList(ModelMap modelMap){
        List<Student> students = studentService.getAllStudents();
        modelMap.addAttribute("students",students);
        return "student-list";
    }
}
