//
//  ViewController.swift
//  task3
//
//  Created by Admin on 06/05/2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import GLKit

extension Array {
    func size() -> Int {
        return MemoryLayout<Element>.stride * self.count
    }
}

extension ViewController: GLKViewControllerDelegate {
    
    func glkViewControllerUpdate(_ controller: GLKViewController) {
        let aspect = fabsf(Float(view.bounds.size.width) / Float(view.bounds.size.height))
        let projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(angle), aspect, 4.0, 16.0)
        effect.transform.projectionMatrix = projectionMatrix
        
        var modelViewMatrix = GLKMatrix4MakeTranslation(0.0, 0.0, -10.0)
        modelViewMatrix = GLKMatrix4Rotate(modelViewMatrix, GLKMathDegreesToRadians(rotation), 0, 1, 0)
        effect.transform.modelviewMatrix = modelViewMatrix
    }
}

class ViewController: GLKViewController {
    private var rotation: Float = 0.0
    private var angle: Float = 100.0

    let Indices = Teapot.Indices
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGL()
    }
    
    @IBAction func swipeRotate(_ sender: Any) {
        rotation -= 20.0
    }
    
    @IBAction func tapEnlarge(_ sender: Any) {
        angle += 5.0
    }
    
    @IBAction func pressLessen(_ sender: Any) {
        angle -= 5.0
    }
    
    override func glkView(_ view: GLKView, drawIn rect: CGRect) {
        glClearColor(0.85, 0.85, 0.85, 1.0)
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT))
        
        effect.prepareToDraw()

        glBindVertexArrayOES(vao);
        glDrawElements(GLenum(GL_TRIANGLES),     // 1
            GLsizei(Indices.count),   // 2
            GLenum(GL_UNSIGNED_BYTE), // 3
            nil)                      // 4
        glBindVertexArrayOES(0)

    }
    
    private var context: EAGLContext?
    
    private func setupGL() {
        context = EAGLContext(api: .openGLES3)
        EAGLContext.setCurrent(context)
        
        if let view = self.view as? GLKView, let context = context {
            view.context = context
            delegate = self
        }
        
        let vertexAttribColor = GLuint(GLKVertexAttrib.color.rawValue)
        let vertexAttribPosition = GLuint(GLKVertexAttrib.position.rawValue)
        let vertexSize = MemoryLayout<Vertex>.stride
        let colorOffset = MemoryLayout<GLfloat>.stride * 3
        let colorOffsetPointer = UnsafeRawPointer(bitPattern: colorOffset)
        
        glGenVertexArraysOES(1, &vao)
        glBindVertexArrayOES(vao)
        
        let teapot = Teapot()
        let Vertices = teapot.Vertices
        
        glGenBuffers(1, &vbo)
        glBindBuffer(GLenum(GL_ARRAY_BUFFER), vbo)
        glBufferData(GLenum(GL_ARRAY_BUFFER),
                     Vertices.size(),
                     Vertices,
                     GLenum(GL_STATIC_DRAW))
        
        glEnableVertexAttribArray(vertexAttribPosition)
        glVertexAttribPointer(vertexAttribPosition,
                              3,
                              GLenum(GL_FLOAT),
                              GLboolean(UInt8(GL_FALSE)),
                              GLsizei(vertexSize),
                              nil)
        
        glEnableVertexAttribArray(vertexAttribColor)
        glVertexAttribPointer(vertexAttribColor,
                              4,
                              GLenum(GL_FLOAT),
                              GLboolean(UInt8(GL_FALSE)),
                              GLsizei(vertexSize),
                              colorOffsetPointer)

        
        glGenBuffers(1, &ebo)
        glBindBuffer(GLenum(GL_ELEMENT_ARRAY_BUFFER), ebo)
        glBufferData(GLenum(GL_ELEMENT_ARRAY_BUFFER),
                     Indices.size(),
                     Indices,
                     GLenum(GL_STATIC_DRAW))

        glBindVertexArrayOES(0)
        glBindBuffer(GLenum(GL_ARRAY_BUFFER), 0)
        glBindBuffer(GLenum(GL_ELEMENT_ARRAY_BUFFER), 0)

    }
    
    private func tearDownGL() {
        EAGLContext.setCurrent(context)
        
        glDeleteBuffers(1, &vao)
        glDeleteBuffers(1, &vbo)
        glDeleteBuffers(1, &ebo)
        
        EAGLContext.setCurrent(nil)
        
        context = nil
    }
    
    deinit {
        tearDownGL()
    }
    
    private var ebo = GLuint()
    private var vbo = GLuint()
    private var vao = GLuint()
    
    private var effect = GLKBaseEffect()

    
}

