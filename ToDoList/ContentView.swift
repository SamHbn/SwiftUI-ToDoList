import SwiftUI

struct Task {
    var title: String
    var isDone: Bool
}

struct ContentView: View {
    @State private var tasks = [
        Task(title: "Faire les courses", isDone: false),
        Task(title: "Coder", isDone: false),
        Task(title: "Sport", isDone: false)
    ]
    @State private var newTask = ""
    
    var cleanNewTask: String {
        newTask.trimmingCharacters(in: .whitespaces)
    }

    var isNewTaskEmpty: Bool {
        cleanNewTask.isEmpty
    }
    
    var remainingTasksCount: Int {
        tasks.filter { !$0.isDone }.count
    }
    
    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
    
    var body: some View {
        VStack {
            Text("Ma ToDo List")
                .font(.largeTitle)
                .padding()
            HStack {
                TextField("Nouvelle tâche", text: $newTask)
                    .textFieldStyle(.roundedBorder)
                Button("Ajouter") {
                    tasks.append(
                        Task(title: cleanNewTask, isDone: false)
                    )
                    newTask = ""
                }
                .disabled(isNewTaskEmpty)
                .opacity(isNewTaskEmpty ? 0.5 : 1)
            }
            .padding(.horizontal, 50)
            .padding(.vertical, 10)
            
            Text("\(remainingTasksCount) tâche(s) restante(s)")
                .font(.subheadline)
                .foregroundStyle(.secondary)
            
            List {
                ForEach(tasks.indices, id: \.self) { index in
                    HStack {
                        Button {
                            tasks[index].isDone.toggle()
                        } label: {
                            if tasks[index].isDone {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundStyle(Color.green)
                            } else {
                                Image(systemName: "circle")
                                    .foregroundStyle(Color.gray)
                            }
                        }

                        Text(tasks[index].title)
                            .strikethrough(tasks[index].isDone)
                            .opacity(tasks[index].isDone ? 0.5 : 1.0)
                    }
                }
                .onDelete(perform: deleteTask)
            }
        }
    }
}

#Preview {
    ContentView()
}
