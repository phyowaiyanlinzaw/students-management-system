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

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;


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
    public ModelAndView studentsList() {
        List<Student> students = studentService.getAllStudents();

        for (Student student : students) {
            List<Course> courses = courseService.getCoursesOfStudent(student.getStudentId());
            student.setStudentCourses(courses);
        }
        ModelAndView modelAndView = new ModelAndView("student-list");
        modelAndView.addObject("students", students);
        return modelAndView;
    }

    @GetMapping("/register")
    public ModelAndView studentRegister(ModelMap modelMap) {
        int count = studentService.getStudentCount();
        if (count == 0) {
            modelMap.addAttribute("studentCount", 1);
        } else {
            modelMap.addAttribute("studentCount", count + 1);
        }
        List<Course> courses = courseService.getAllCourses();
        modelMap.addAttribute("courses", courses);
        return new ModelAndView("student-register", "student", new Student());
    }

    @PostMapping("/register")
    public String studentRegister(
            @ModelAttribute("student") Student student,
            ModelMap modelMap,
            @RequestParam("photo") MultipartFile photo,
            RedirectAttributes redirectAttributes
    ) throws IOException {


        try {
            if (student.getStudentName().isEmpty() || student.getStudentDob().isEmpty()
                    || student.getStudentGender().isEmpty() || student.getStudentPhone().isEmpty()
                    || student.getStudentEducation().isEmpty() || student.getStudentCourse().isEmpty()
            ) {
                modelMap.addAttribute("message", "emptyError");
                return "student-register";
            }
        } catch (NullPointerException e) {
            System.out.println(e.getMessage());
            modelMap.addAttribute("message", "emptyError");
            return "student-register";
        }

        String[] coursesNames = student.getStudentCourse().split(",");

        //phone number duplicate
        List<Student> students = studentService.getAllStudents();
        for (Student s : students) {
            if (s.getStudentPhone().equalsIgnoreCase(student.getStudentPhone())) {
                redirectAttributes.addFlashAttribute("message", "stuDupeError");
                return "redirect/student/register";
            }
        }

        String photoName = photo.getOriginalFilename();
        student.setStudentPhotoName(photoName);

        byte[] studentPhoto = photo.getBytes();
        student.setStudentPhoto(studentPhoto);

        List<Course> studentCourses = new ArrayList<>();


        for (String coursesName : coursesNames) {
            Course course = courseService.getCourseByName(coursesName);
            studentCourses.add(course);
        }

        student.setStudentCourses(studentCourses);

        int result = studentService.registerStudent(student);

        if (result < 1) {
            modelMap.addAttribute("message", "studentAddError");
            return "student-register";
        }

        redirectAttributes.addFlashAttribute("message", "studentAddSuccess");
        return "redirect:/student/list";
    }

    @GetMapping("/photo")
    public void displayPhoto(@RequestParam("studentId") int studentId, HttpServletResponse response) {
        Student student = studentService.getOneStudent(studentId);
        if (student != null && student.getStudentPhoto() != null) {
            response.setContentType("image/jpeg");
            try (OutputStream outputStream = response.getOutputStream()) {
                byte[] photoData = student.getStudentPhoto(); // Assuming getStudentPhoto() returns byte[]
                outputStream.write(photoData);
            } catch (IOException e) {
                System.out.println(e.getMessage()); // Log the exception
            }
        }
    }

    @GetMapping("/edit")
    public ModelAndView editStudent(
            @RequestParam("studentId") int studentId,
            ModelMap modelMap
    ) {
        List<Course> courses = courseService.getAllCourses();
        modelMap.addAttribute("courses", courses);
        Student student = studentService.getOneStudent(studentId);
        modelMap.addAttribute("studentId", studentId);
        return new ModelAndView("student-edit", "student", student);
    }

    @PostMapping("/edit")
    public String editStudent(
            @ModelAttribute("student") Student student,
            @RequestParam("photo") MultipartFile photo,
            @RequestParam("studentCourse") String[] courses,
            ModelMap modelMap,
            RedirectAttributes redirectAttributes
    ) throws IOException {
        try {
            if (student.getStudentName().isEmpty() || student.getStudentDob().isEmpty()
                    || student.getStudentGender().isEmpty() || student.getStudentPhone().isEmpty()
                    || student.getStudentEducation().isEmpty()
            ) {
                modelMap.addAttribute("message", "emptyError");
                return "student-edit";
            }
        } catch (NullPointerException e) {
            System.out.println(e.getMessage());
            modelMap.addAttribute("message", "emptyError");
            return "student-edit";
        }


        String photoName = photo.getOriginalFilename();
        student.setStudentPhotoName(photoName);

        byte[] studentPhoto = photo.getBytes();
        student.setStudentPhoto(studentPhoto);

        List<Course> studentCourses = new ArrayList<>();


        for (String coursesName : courses) {
            Course course = courseService.getCourseByName(coursesName);
            studentCourses.add(course);
        }

        student.setStudentCourses(studentCourses);

        student.setStudentId(student.getStudentId());

        student.setStatus("active");


        int result = studentService.updateStudent(student);

        if (result < 1) {
            modelMap.addAttribute("message", "stuEditError");
            return "student-edit";
        }


        redirectAttributes.addFlashAttribute("message", "stuEditSuccess");
        return "redirect:/student/list";
    }

    @GetMapping("/delete")
    public String deleteStudent(
            @RequestParam("studentId") int studentId,
            RedirectAttributes redirectAttributes
    ) {
        int result = studentService.deleteStudent(studentId);
        if (result < 1) {
            redirectAttributes.addFlashAttribute("message", "stuDeleteError");
            return "redirect:/student/list";
        }
        redirectAttributes.addFlashAttribute("message", "stuDeleteSuccess");
        return "redirect:/student/list";
    }

}
