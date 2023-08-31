package app.controller;

import app.model.Course;
import app.model.User;
import app.service.CourseServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/course")
@ComponentScan("app")
@Component
public class CourseController {

    @Autowired
    CourseServiceImpl courseService;

    @GetMapping("/register")
    public ModelAndView courseRegister(ModelMap modelMap){
        int courseCount = courseService.courseCount();
        System.out.println(courseCount);
        if (courseCount==0){
            modelMap.addAttribute("courseCount",1);
        }else{
            modelMap.addAttribute("courseCount",courseCount+1);
        }
        return new ModelAndView("course-register","course",new Course());
    }

    @PostMapping("/register")
    public String courseRegister(
            @ModelAttribute("course") Course course,
            ModelMap model,
            RedirectAttributes redirectAttributes,
            HttpSession session
    ){

        List<Course> courses = courseService.getAllCourses();

        for (Course c : courses) {
            if (course.getCourseName().equals(c.getCourseName())) {
                System.out.println("Dupe Course");
                model.addAttribute("message", "courseDupe");
                return "course-register";
            }
        }

        try{
            if (course.getCourseName().trim().isEmpty() || course.getCourseDescription().trim().isEmpty()) {
                System.out.println("EMPTY");
                redirectAttributes.addFlashAttribute("message", "emptyError");
                return "redirect:/course/register";
            }
        }catch (NullPointerException e){
            System.out.println("Empty");
            redirectAttributes.addFlashAttribute("message", "emptyError");
            return "redirect:/course/register";
        }

        User currentUser = (User) session.getAttribute("currentUser");
        course.setAddedBy(currentUser.getUserId());

        int result = courseService.registerCourse(course);

        if(result<1){
            System.out.print("Error Adding");
            model.addAttribute("message","courseAddError");
            return "course-add";
        }
        redirectAttributes.addFlashAttribute("message","courseAddSuccess");
        return "redirect:/course/list";
    }

    @GetMapping("/list")
    public String coursesList(ModelMap modelMap){
        List<Course> courses = courseService.getAllCourses();
        modelMap.addAttribute("courses",courses);
        return "course-list";
    }

    @GetMapping("/edit/{code}")
    public ModelAndView courseEdit(@PathVariable String code){
        System.out.println(courseService.getOneCourse(code).getCourseName());
        return new ModelAndView("course-edit","course",courseService.getOneCourse(code));
    }

    @PostMapping("/edit")
    public String courseEdit(
            @ModelAttribute("course") Course course,
            ModelMap modelMap,
            RedirectAttributes redirectAttributes
    ){

        try{
            if(course.getCourseName().isEmpty()||course.getCourseDescription().isEmpty()){
                modelMap.addAttribute("message","emptyError");
                return "course-edit";
            }
        }catch (NullPointerException e){
            modelMap.addAttribute("message","emptyError");
            return "course-edit";
        }

        System.out.println("description : " + course.getCourseDescription());
        System.out.println("courseID : " + course.getDisplayCourseId());


        int result = courseService.updateCourse(course);
        System.out.println(result);
        if(result<1){
            modelMap.addAttribute("message","courseEditError");
            return "course-edit";
        }else{
            System.out.print("result : " + result);
            modelMap.addAttribute("message","courseEditSuccess");
            return "redirect:/course/list";
        }

    }

    @GetMapping("/delete")
    public String courseDelete(
            @RequestParam("courseId") String courseId,
ModelMap modelMap,
            RedirectAttributes redirectAttributes
    ){
        int result = courseService.deleteCourse(courseId);
        if(result<1){
            redirectAttributes.addFlashAttribute("message","courseDeleteError");
            return "redirect:/course/list";
        }
        redirectAttributes.addFlashAttribute("message","courseDeleteSuccess");

        return "redirect:/course/list";
    }
}
